import 'package:winwin/data/model/application.dart';
import 'package:winwin/error/exceptions.dart';
import 'package:winwin/services/network_service_response.dart';
import 'package:winwin/services/restclient.dart';

abstract class ApplicationRemoteDataSource {
  Future<Application> apply(String candidateId, String jobPositionId);
  Future<ApplicationListResponseModel> getCandidateApplications(
      String candidateId, String? statusId);
  Future<ApplicationListResponseModel> getJobPositionApplications(
      String jobPositionId);
  Future<Application> getApplication(int applicationId);
}

class ApplicationRemoteDataSourceImpl implements ApplicationRemoteDataSource {
  final RestClient client;

  ApplicationRemoteDataSourceImpl({required this.client});

  @override
  Future<ApplicationListResponseModel> getCandidateApplications(
      String candidateId, String? statusId) async {
    MappedNetworkServiceResponse response;
    var queryParameters = {
      'candidate_id': candidateId,
    };
    if (statusId != null) {
      queryParameters['status_id'] = statusId;
    }
    response = await client.get(
      '/api/v1/candidate/applications',
      queryParameters: queryParameters,
    );
    if (response.networkServiceResponse.success) {
      return ApplicationListResponseModel.fromJson(response.mappedResult);
    } else {
      throw ApplicationFetchException(response.networkServiceResponse.message);
    }
  }

  @override
  Future<Application> apply(String candidateId, String jobPositionId) async {
    MappedNetworkServiceResponse response;
    response = await client.post(
      '/api/v1/candidate/apply/',
      {
        'candidate_id': candidateId,
        'job_position_id': jobPositionId,
      },
    );
    print(response.networkServiceResponse.message);
    if (response.networkServiceResponse.success) {
      return Application.fromJson(response.mappedResult);
    } else {
      throw ApplicationFetchException(response.networkServiceResponse.message);
    }
  }

  @override
  Future<ApplicationListResponseModel> getJobPositionApplications(
      String jobPositionId) async {
    MappedNetworkServiceResponse response;
    response = await client.get(
      '/api/v1/company/applications',
      queryParameters: {
        'job_position_id': jobPositionId,
      },
    );
    if (response.networkServiceResponse.success) {
      return ApplicationListResponseModel.fromJson(response.mappedResult);
    } else {
      throw ApplicationFetchException(response.networkServiceResponse.message);
    }
  }

  @override
  Future<Application> getApplication(int applicationId) async {
    MappedNetworkServiceResponse response;
    response = await client.get('/api/v1/applications/$applicationId');
    if (response.networkServiceResponse.success) {
      return Application.fromJson(response.mappedResult);
    } else {
      throw ApplicationFetchException(response.networkServiceResponse.message);
    }
  }
}
