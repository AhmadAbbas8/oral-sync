import 'package:dio/dio.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';

import '../../../../core/error/error_model.dart';
import '../../../../core/error/exception.dart';
import '../models/reservation_model.dart';

abstract class ReservationsRemoteDataSource {
  Future<List<ReservationModel>> getAllReservationsCompleted(String endPoint);
}

class ReservationsRemoteDataSourceImpl implements ReservationsRemoteDataSource {
  ReservationsRemoteDataSourceImpl({required this.api});

  final ApiConsumer api;

  @override
  Future<List<ReservationModel>> getAllReservationsCompleted(String endPoint) async {
    try {
      Response response =
          await api.get(endPoint);
      List<ReservationModel> reservations = [];
      if (response.statusCode == 200) {
        for (var val in response.data) {
          reservations.add(ReservationModel.fromJson(val));
        }
        return reservations;
      }else if(response.statusCode == 404){
        throw ServerException(
          errorModel: ResponseModel.fromJson(response.data),
        );
      } else {
        throw ServerException(
          errorModel: ResponseModel(
              messageEn: 'Server Error', messageAr: 'مشكلة فى السيرفر'),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        errorModel: ResponseModel.fromJson(e.response?.data),
      );
    }
  }
}
