import 'package:dio/dio.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/Notification_model.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/ratings_model.dart';

import '../../../features/Auth/data/models/user_model.dart';
import '../../error/error_model.dart';
import '../../error/exception.dart';
import '../../utils/end_points.dart';

abstract class ActionsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();

  Future<ResponseModel> addLikeRemoveLike(int postId);

  Future<ResponseModel> createReserve(Map<String, dynamic> data);

  Future<List<RatingModel>> getAllRates(String userId);

  Future<UserModel> getUserData(String userId);
}

class ActionsRemoteDataSourceImpl extends ActionsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ActionsRemoteDataSourceImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      Response response =
          await _apiConsumer.get(EndPoints.notificationsEndPoint);
      if (response.statusCode == 200) {
        List<NotificationModel> notificationList = [];
        for (var val in response.data) {
          notificationList.add(NotificationModel.fromJson(val));
        }
        return notificationList;
      } else {
        throw ServerException(
            errorModel: ResponseModel(
                messageEn: 'Server Error', messageAr: 'مشكلة فى السيرفر'));
      }
    } on DioException catch (e) {
      throw ServerException(
          errorModel: ResponseModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<ResponseModel> addLikeRemoveLike(int postId) async {
    try {
      Response response = await _apiConsumer.post(
        EndPoints.addLikeEndPoint,
        queryParameters: {'PostId': postId},
      );
      if (response.statusCode == 200 || response.statusCode == 404) {
        return ResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorModel: ResponseModel(
            messageEn: 'Server Error',
            messageAr: 'مشكلة فى السيرفر',
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
          errorModel: ResponseModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<ResponseModel> createReserve(Map<String, dynamic> data) async {
    try {
      Response response = await _apiConsumer.post(
        EndPoints.createAppointmentEndPoint,
        data: data,
      );
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      } else if (response.statusCode == 402 ||
          response.statusCode == 406 ||
          response.statusCode == 403 ||
          response.statusCode == 407) {
        throw ServerException(
            errorModel: ResponseModel.fromJson(response.data));
      } else {
        throw ServerException(
          errorModel: ResponseModel(
            messageEn: 'Server Error',
            messageAr: 'مشكلة فى السيرفر',
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
          errorModel: ResponseModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<List<RatingModel>> getAllRates(String userId) async {
    try {
      Response response = await _apiConsumer.get(
        EndPoints.getRatingsEndPoint,
        queryParameters: {'userId': userId},
      );
      List<RatingModel> rates = [];
      if (response.statusCode == 200) {
        for (var val in response.data) {
          rates.add(RatingModel.fromJson(val));
        }
        return rates;
      } else if (response.statusCode == 404) {
        throw ServerException(
            errorModel: ResponseModel.fromJson(response.data));
      } else {
        throw ServerException(
          errorModel: ResponseModel(
            messageEn: 'Server Error',
            messageAr: 'مشكلة فى السيرفر',
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
          errorModel: ResponseModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<UserModel> getUserData(String userId) async {
    try {
      Response response = await _apiConsumer.get(
        EndPoints.userProfileEndPoint,
        queryParameters: {'userId': userId},
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorModel: ResponseModel(
            messageEn: 'Server Error',
            messageAr: 'مشكلة فى السيرفر',
          ),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
          errorModel: ResponseModel.fromJson(e.response?.data));
    }
  }
}
