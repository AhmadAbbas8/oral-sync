import 'package:dio/dio.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/shared_data_layer/actions_data_layer/model/Notification_model.dart';

import '../../error/error_model.dart';
import '../../error/exception.dart';
import '../../utils/end_points.dart';

abstract class ActionsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();

  Future<ResponseModel> addLikeRemoveLike(int postId);
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
}
