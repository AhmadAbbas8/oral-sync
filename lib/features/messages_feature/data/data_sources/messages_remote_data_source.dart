import 'package:dio/dio.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/messages_feature/data/models/start_message_model.dart';

import '../../../../core/error/error_model.dart';

abstract class MessagesRemoteDataSource {
  Future<List<StartMessageModel>> getAllStartMessages();

  Future<ResponseModel> startMessage({
    required String receiverId,
  });
}

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final ApiConsumer apiConsumer;

  MessagesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<StartMessageModel>> getAllStartMessages() async {
    try {
      var res = await apiConsumer.get(EndPoints.getAllMessageDetailsEndPoint);
      return (res.data as List)
          .map<StartMessageModel>((e) => StartMessageModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        errorModel: ResponseModel.fromJson(e.response?.data),
      );
    }
  }

  @override
  Future<ResponseModel> startMessage({
    required String receiverId,
  }) async {
    try {
      var res = await apiConsumer
          .post(EndPoints.addMessageEndPoint, queryParameters: {
        'ReceiverId': receiverId,
      });
      return ResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      throw ServerException(
        errorModel: ResponseModel.fromJson(e.response?.data),
      );
    }
  }
}
