import 'package:dio/dio.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';

abstract class EditProfileRemoteDataSource {
  Future<UserModel> updateData({
    required Map<String, dynamic> data,
    required String endPoint,
  });

  Future<UserModel> getUserData();
}

class EditProfileRemoteDataSourceIml implements EditProfileRemoteDataSource {
  final ApiConsumer _apiConsumer;

  const EditProfileRemoteDataSourceIml({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<UserModel> updateData({
    required Map<String, dynamic> data,
    required String endPoint,
  }) async {
    try {
      Response response = await _apiConsumer.put(endPoint, data: data);
      if (response.statusCode == 200) {
        try {
          var userData = await getUserData();
          return userData;
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
          errorModel: ResponseModel.fromJson(ex.response?.data));
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      Response response = await _apiConsumer.get(EndPoints.findUserEndPoint);
      if (response.statusCode == 200) {
        UserModel model = UserModel.fromJson(response.data);
        return model;
      } else {
        throw ServerException(
            errorModel: ResponseModel.fromJson(response.data));
      }
    } on DioException catch (ex) {
      throw ServerException(
          errorModel: ResponseModel.fromJson(ex.response?.data));
    }
  }
}
