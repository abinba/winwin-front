import 'package:dartz/dartz.dart';

import 'package:winwin/data/datasource/job_position_remote_data_source.dart';
import 'package:winwin/data/model/job_position.dart';
import 'package:winwin/error/exceptions.dart';
import 'package:winwin/error/failure.dart';
import 'package:winwin/services/network_info.dart';

class JobPositionRepository {
  final JobPositionRemoteDataSourceImpl jobPositionRemoteDataSource;
  final NetworkInfoImpl networkInfo;

  JobPositionRepository({
    required this.jobPositionRemoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, JobPositionListResponseModel>> getRecommendedJobPositions(
      {String? candidateId}) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response =
            await jobPositionRemoteDataSource.getRecommendedJobPositions(candidateId);
        return Right(response);
      } on JobPositionFetchException catch (error) {
        String message = error.message ?? 'Something went wrong';
        return Left(ServerFailure(message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, JobPosition>> getJobPosition(int jobPositionId) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response =
            await jobPositionRemoteDataSource.getJobPosition(jobPositionId);
        return Right(response);
      } on JobPositionFetchException catch (error) {
        String message = error.message ?? 'Something went wrong';
        return Left(ServerFailure(message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
