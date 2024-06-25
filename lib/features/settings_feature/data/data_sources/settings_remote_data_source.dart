import 'package:dio/dio.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/utils/end_points.dart';

abstract class SettingsRemoteDataSource {
  Future<ResponseModel> convertStudentAccountToDoctorAccount({
    required String userId,
  });

  Future<ResponseModel> updateUserPassword({
    required String newPassword,
  });
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiConsumer _api;

  SettingsRemoteDataSourceImpl({
    required ApiConsumer api,
  }) : _api = api;

  @override
  Future<ResponseModel> convertStudentAccountToDoctorAccount({
    required String userId,
  }) async {
    try {
      Response response = await _api.post(
        EndPoints.convertStudentToDoctorEndPoint,
        queryParameters: {'userId': userId},
      );
      if (response.statusCode == 200) {
        try {
          return ResponseModel.fromJson(response.data);
        } catch (e) {
          throw ServerException(
              errorModel: ResponseModel(
                  messageEn: 'Server Error', messageAr: 'مشكلة فى السيرفر'));
        }
      } else {
        throw ServerException(
            errorModel: ResponseModel.fromJson(response.data));
      }
    } on DioException catch (ex) {
      throw ServerException(
        errorModel: ResponseModel.fromJson(ex.response?.data),
      );
    }
  }

  @override
  Future<ResponseModel> updateUserPassword({
    required String newPassword,
  }) async {
    try {
      Response response = await _api.post(
        EndPoints.updatePasswordEndPoint,
        data: {"newPassword": newPassword},
      );
      if (response.statusCode == 200) {
        try {
          return ResponseModel.fromJson(response.data);
        } catch (e) {
          throw ServerException(
              errorModel: ResponseModel(
                  messageEn: 'Server Error', messageAr: 'مشكلة فى السيرفر'));
        }
      } else {
        throw ServerException(
            errorModel: ResponseModel.fromJson(response.data));
      }
    } on DioException catch (ex) {
      throw ServerException(
        errorModel: ResponseModel.fromJson(ex.response?.data),
      );
    }
  }
}
