import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final _dio = ServiceLocator.instance<Dio>();

  @override
  Future<Unit> login({required String email, required String password}) async {
    Response response = await _dio.post(
      EndPoints.loginEndPoint,
      data: {
        "email": email,
        "password": password,
      },
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> register(
      {required String fName,
      required String sName,
      required String email,
      required String password,
      required String confirmPassword,
      required String phoneNumber,
      required bool isMale,
      required bool isDoctor,
      required bool isStudent,
      required bool isPatient}) async {
    Response response = await _dio.post(
      EndPoints.registerEndPoint,
      data: {
        "id": "string",
        "name": fName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "isMale": isMale,
        "phoneNumber": phoneNumber,
        "isDoctor": isDoctor,
        "isStudent": isStudent,
        "isPatient": isPatient,
      },
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> signUpDoctor(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool gender,
      required bool isDoctor,
      required String academicYear,
      required String GPA,
      required String clinicGovernment,
      required String clinicCity,
      required String clinicStreet,
      required String clinicFloor,
      required String other,
      required String password}) async {
    Response response = await _dio.post(
      EndPoints.addDoctorEndPoint,
      data: {},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> signUpPatient(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool gender,
      required String government,
      required String city}) async {
    Response response = await _dio.post(
      EndPoints.addPatientEndPoint,
      data: {},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> signUpStudent(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool gender,
      required bool isDoctor,
      required String academicYear,
      required String GPA,
      required String universityGovernment,
      required String universityCity,
      required String universityStreet,
      required String other,
      required String password}) async {
    Response response = await _dio.post(
      EndPoints.addStudentEndPoint,
      data: {},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
