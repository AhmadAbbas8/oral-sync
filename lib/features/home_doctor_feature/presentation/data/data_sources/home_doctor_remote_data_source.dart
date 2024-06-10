import 'package:dio/dio.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/reservations_feature/data/models/reservation_model.dart';

import '../../../../../core/error/error_model.dart';
import '../../../../../core/error/exception.dart';

abstract class HomeDoctorRemoteDataSource {
  Future<List<ReservationModel>> getAllReservationsForDoctor();
}

class HomeDoctorRemoteDataSourceImpl implements HomeDoctorRemoteDataSource {
  final ApiConsumer api;

  const HomeDoctorRemoteDataSourceImpl({required this.api});

  @override
  Future<List<ReservationModel>> getAllReservationsForDoctor() async {
    try {
      Response response =
          await api.get(EndPoints.getWaitingScheduledDoctorAppointmentEndPoint);
      List<ReservationModel> reservations = [];
      if (response.statusCode == 200) {
        for (var val in response.data) {
          reservations.add(ReservationModel.fromJson(val));
        }
        return reservations;
      } else if (response.statusCode == 404) {
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
