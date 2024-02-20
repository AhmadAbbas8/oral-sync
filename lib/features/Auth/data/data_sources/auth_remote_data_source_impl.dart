import 'package:dio/dio.dart';
import 'package:oralsync/core/error/error_model.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';

import 'package:oralsync/features/Auth/data/models/register_body_model.dart';

import '../models/user_model.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  const AuthRemoteDataSourceImp({required this.apiConsumer});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await apiConsumer.post(
        EndPoints.loginEndPoint,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        return user;
      } else {
        throw ServerException(errorModel: ResponseModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      throw ServerException(errorModel: ResponseModel.fromJson(e.response?.data));
    }
  }

  @override
  Future<RegisterBodyModel> newRegister({
    required String email,
    required String password,
    required String confirmPassword,
    required bool isMale,
    required String phoneNumber,
    required bool isDoctor,
    required bool isStudent,
    required bool isPatient,
    required String fName,
    required String lName,
    String? universityName,
    List<String?>? clinicAddress,
    List<String?>? insuranceCompanies,
    List<String?>? certificates,
    String? clinicNumber,
    double? gpa,
    String? birthDate,
    String? graduationDate,
    List<String?>? address,
    String? insuranceCompany,
    List<String?>? universitAddress,
    int? academicYear,
  }) async {
    try {
      Response response = await apiConsumer.post(
        EndPoints.newRegisterEndPoint,
        data: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "isMale": isMale,
          "phoneNumber": phoneNumber,
          "isDoctor": isDoctor,
          "isStudent": isStudent,
          "isPatient": isPatient,
          "firstName": fName,
          "lastName": lName,
          "universityName": universityName,
          "clinicAddress": clinicAddress,
          "clinicNumber": clinicNumber,
          "insuranceCompanies": insuranceCompanies,
          "certificates": certificates,
          "gpa": gpa,
          "birthDate": birthDate,
          "graduationDate": graduationDate,
          "address": address,
          "insuranceCompany": insuranceCompany,
          "universitAddress": universitAddress,
          "academicYear": academicYear
        },
      );
      if (response.statusCode == 200) {
        RegisterBodyModel model = RegisterBodyModel.fromJson(response.data);
        return model;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }
}
