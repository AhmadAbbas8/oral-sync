import 'package:dio/dio.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';

import '../../../../core/error/error_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/utils/end_points.dart';
import '../models/reservation_model.dart';

abstract class ReservationsRemoteDataSource {
  Future<List<ReservationModel>> getAllReservationsCompleted();
}

class ReservationsRemoteDataSourceImpl implements ReservationsRemoteDataSource {
  ReservationsRemoteDataSourceImpl({required this.api});

  final ApiConsumer api;

  @override
  Future<List<ReservationModel>> getAllReservationsCompleted() async {
    try {
      Response response =
          await api.get(EndPoints.getCompletedPatientAppointmentEndPoint);
      List<ReservationModel> reservations = [];
      if (response.statusCode == 200) {
        for (var val in response.data) {
          reservations.add(ReservationModel.fromJson(val));
        }
        return reservations;
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
