import 'package:dio/dio.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/features/home_student_feature/data/models/Notification_model.dart';

import '../../../../core/error/error_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/end_points.dart';

abstract class ActionsRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
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
}
