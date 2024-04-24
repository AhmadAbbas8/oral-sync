import 'package:dio/dio.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/utils/end_points.dart';

import '../../../core/error/exception.dart';
import '../../../core/network/api/api_consumer.dart';

abstract class ContactUsDataSource {
  Future<ResponseModel> sendFeedback({
    required String message,
    String? name,
    String? phoneNumber,
    String? email,
  });
}

class ContactUsDataSourceImpl extends ContactUsDataSource {
  final ApiConsumer _apiConsumer;

  ContactUsDataSourceImpl({
    required ApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  @override
  Future<ResponseModel> sendFeedback({
    required String message,
    String? name,
    String? phoneNumber,
    String? email,
  }) async {
    try {
      Response response = await _apiConsumer.put(
        EndPoints.saveContactUsEndPoint,
        data: {
          "fullName": name,
          "email": email,
          "phoneNumber": phoneNumber,
          "message": message,
        },
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
          errorModel: ResponseModel.fromJson(ex.response?.data));
    }
  }
}
