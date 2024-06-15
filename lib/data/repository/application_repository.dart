import 'package:dartz/dartz.dart';
import 'package:winwin/data/datasource/application_remote_data_source.dart';
import 'package:winwin/data/model/application.dart';
import 'package:winwin/error/exceptions.dart';
import 'package:winwin/error/failure.dart';
import 'package:winwin/services/network_info.dart';

class ApplicationRepository {
  final ApplicationRemoteDataSourceImpl applicationRemoteDataSource;
  final NetworkInfoImpl networkInfo;

  ApplicationRepository({
    required this.applicationRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, Application>> apply(String candidateId, String jobPositionId) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await applicationRemoteDataSource.apply(candidateId, jobPositionId);
        return Right(response);
      } on ApplicationFetchException catch (error) {
        String message = error.message ?? 'Something went wrong';
        return Left(ServerFailure(message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, ApplicationListResponseModel>> getCandidateApplications(String candidateId) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await applicationRemoteDataSource.getCandidateApplications(candidateId);
        return Right(response);
      } on ApplicationFetchException catch (error) {
        String message = error.message ?? 'Something went wrong';
        return Left(ServerFailure(message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, ApplicationListResponseModel>> getJobPositionApplications(String jobPositionId) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await applicationRemoteDataSource.getJobPositionApplications(jobPositionId);
        return Right(response);
      } on ApplicationFetchException catch (error) {
        String message = error.message ?? 'Something went wrong';
        return Left(ServerFailure(message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, Application>> getApplication(int applicationId) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await applicationRemoteDataSource.getApplication(applicationId);
        return Right(response);
      } on ApplicationFetchException catch (error) {
        String message = error.message ?? 'Something went wrong';
        return Left(ServerFailure(message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
