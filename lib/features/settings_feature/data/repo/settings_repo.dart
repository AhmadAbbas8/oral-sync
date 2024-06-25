import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/features/settings_feature/data/data_sources/settings_remote_data_source.dart';

import '../../../../core/error/error_model.dart';

abstract class SettingsRepo {
  Future<Either<Failure, ResponseModel>> convertStudentAccountToDoctorAccount({
    required String userId,
  });

  Future<Either<Failure, ResponseModel>> updateUserPassword({
    required String newPassword,
  });
}

class SettingsRepoImpl implements SettingsRepo {
  final SettingsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  SettingsRepoImpl({
    required SettingsRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, ResponseModel>> convertStudentAccountToDoctorAccount({
    required String userId,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        var model =
            await _remoteDataSource.convertStudentAccountToDoctorAccount(
          userId: userId,
        );
        return Right(model);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> updateUserPassword({
    required String newPassword,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        var model = await _remoteDataSource.updateUserPassword(newPassword: newPassword);
        return Right(model);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
