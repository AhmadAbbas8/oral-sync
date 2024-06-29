import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/reservations_feature/data/models/reservation_model.dart';

import '../../../../../core/error/error_model.dart';
import '../../../../../core/error/exception.dart';

abstract class HomeDoctorRemoteDataSource {
  Future<List<ReservationModel>> getAllReservationsForDoctor();

  Future<ResponseModel> updateReservation({
    required String status,
    required int reservationId,
    required String doctorNotes,
  });

  Future<List<ReservationModel>> getPatientHistory({required String patientId});
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

  @override
  Future<ResponseModel> updateReservation({
    required String status,
    required int reservationId,
    required String doctorNotes,
  }) async {
    try {
      Response response = await api
          .put('${EndPoints.updateAppointmentEndPoint}/$reservationId', data: {
        "status": status,
        "patientNotes": "No Notes",
        "doctorNotes": doctorNotes,
        "dateAppointment":
            DateFormat('yyyy/MM/dd', 'EN').format(DateTime.now()),
        "timeAppointment": DateFormat('HH:mm:ss', 'EN').format(DateTime.now()),
      });
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
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

  @override
  Future<List<ReservationModel>> getPatientHistory(
      {required String patientId}) async {
    try {
      Response response = await api.get(
          EndPoints.getCompletedPatientAppointmentByUserIdEndPoint,
          queryParameters: {'userId': patientId});
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
