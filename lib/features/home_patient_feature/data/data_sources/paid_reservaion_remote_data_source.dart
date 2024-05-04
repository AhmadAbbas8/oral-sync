import 'package:dio/dio.dart';

import '../../../../core/error/error_model.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/api/api_consumer.dart';
import '../../../../core/utils/end_points.dart';
import '../models/DoctorModel.dart';

abstract class PaidReservationRemoteDataSource {
  Future<List<DoctorModel>> getAllDoctors({
    double? minRate,
    String? insuranceCompany,
    String? governorate,
  });
}

class PaidReservationRemoteDataSourceImpl
    implements PaidReservationRemoteDataSource {
  final ApiConsumer _apiConsumer;

  PaidReservationRemoteDataSourceImpl({
    required ApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  @override
  Future<List<DoctorModel>> getAllDoctors({
    double? minRate,
    String? insuranceCompany,
    String? governorate,
  }) async {
    List<DoctorModel> doctors = [];
    try {
      Response response = await _apiConsumer.get(
        EndPoints.filterDoctorsByGovernorateAndRateEndPoint,
        queryParameters: {'minRate': minRate, 'governorate': governorate},
      );
      if (response.statusCode == 200) {
        for (var doctor in response.data) {
          doctors.add(DoctorModel.fromJson(doctor));
        }
        return doctors;
      } else {
        throw ServerException(
          errorModel: ResponseModel(
              messageEn: 'Server Error', messageAr: 'مشكلة فى السيرفر'),
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        errorModel: ResponseModel.fromJson(
          e.response?.data,
        ),
      );
    }
  }
}
