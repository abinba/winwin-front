import 'package:winwin/config/constant_config.dart';
import 'package:winwin/data/model/job_position.dart';
import 'package:winwin/error/exceptions.dart';
import 'package:winwin/services/network_service_response.dart';
import 'package:winwin/services/restclient.dart';

abstract class JobPositionRemoteDataSource {
  /// Calls the [baseUrl]/v1/job_positions endpoint
  ///
  /// Throws a [JobPositionFetchException] for all error codes.
  Future<JobPositionListResponseModel> getRecommendedJobPositions(String? categoryId);
  Future<JobPosition> getJobPosition(int jobPositionId);
}

class JobPositionRemoteDataSourceImpl implements JobPositionRemoteDataSource {
  final RestClient client;
  final ConstantConfig constantConfig = ConstantConfig();

  JobPositionRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<JobPositionListResponseModel> getRecommendedJobPositions(String? candidateId) async {
    MappedNetworkServiceResponse response;
    if (candidateId == null) {
      response = await client.get(
        '/api/v1/candidate/recommendations',
      );
    } else {
      response = await client.get(
        '/api/v1/candidate/recommendations',
        queryParameters: {
          'candidate_id': candidateId,
        },
      );
    }
    if (response.networkServiceResponse.success) {
      return JobPositionListResponseModel.fromJson(response.mappedResult);
    } else {
      throw JobPositionFetchException(response.networkServiceResponse.message);
    }
  }

  @override
  Future<JobPosition> getJobPosition(int jobPositionId) async {
    MappedNetworkServiceResponse response;
    response = await client.get(
      '/api/v1/job_positions/$jobPositionId',
    );
    if (response.networkServiceResponse.success) {
      return JobPosition.fromJson(response.mappedResult);
    } else {
      throw JobPositionFetchException(response.networkServiceResponse.message);
    }
  }
}
