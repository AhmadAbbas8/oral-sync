import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/core/shared_data_layer/edit_profile_data_layer/edit_profile_remote_data_source.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';

import '../../error/exception.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, Unit>> updateDoctorProfile({
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, Unit>> updateStudentProfile({
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, Unit>> updatePatientProfile({
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, UserModel>> updateImageProfile({
    required Map<String, dynamic> data,
  });
}

class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileRemoteDataSource _editProfileRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  final NetworkInfo _networkInfo;

  EditProfileRepoImpl({
    required EditProfileRemoteDataSource editProfileRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
    required NetworkInfo networkInfo,
  })  : _editProfileRemoteDataSource = editProfileRemoteDataSource,
        _authLocalDataSource = authLocalDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, Unit>> updateDoctorProfile(
      {required Map<String, dynamic> data}) async {
    if (await _networkInfo.isConnected) {
      try {
        var model = await _editProfileRemoteDataSource.updateData(
            data: data, endPoint: EndPoints.updateProfileDoctorEndPoint);
        await _authLocalDataSource.cacheUser(userModel: model);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePatientProfile(
      {required Map<String, dynamic> data}) async {
    if (await _networkInfo.isConnected) {
      try {
        var model = await _editProfileRemoteDataSource.updateData(
            data: data, endPoint: EndPoints.updateProfilePatientEndPoint);
        await _authLocalDataSource.cacheUser(userModel: model);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateStudentProfile({
    required Map<String, dynamic> data,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        var model = await _editProfileRemoteDataSource.updateData(
            data: data, endPoint: EndPoints.updateProfileStudentEndPoint);
        await _authLocalDataSource.cacheUser(userModel: model);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateImageProfile(
      {required Map<String, dynamic> data}) async {
    if (await _networkInfo.isConnected) {
      try {
        var model = await _editProfileRemoteDataSource.updateImageProfile(
          data: data,
        );
        await _authLocalDataSource.cacheUser(userModel: model);
        return  Right(model);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorModel: e.errorModel));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
