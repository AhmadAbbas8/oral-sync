import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oralsync/core/error/exception.dart';
import 'package:oralsync/core/network/api/api_consumer.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_remote_data_source.dart';
import 'package:oralsync/features/Auth/data/models/added_body_model.dart';
import 'package:oralsync/features/Auth/data/models/register_body_model.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';
import 'package:oralsync/features/Auth/domain/entities/added.dart';
import 'package:oralsync/features/Auth/domain/entities/user.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  const AuthRemoteDataSourceImp({required this.apiConsumer});

  @override
  Future<User> login({required String email, required String password}) async {
    Response response = await apiConsumer.post(
      EndPoints.loginEndPoint,
      data: {
        "email": email,
        "password": password,
      },
    );
    if (response.statusCode == 200) {
      User user = UserModel.fromJson(response.data);
      return user;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RegisterBodyModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required bool isMale,
    required bool isDoctor,
    required bool isStudent,
    required bool isPatient,
  }) async {
    Response response = await apiConsumer.post(
      EndPoints.registerEndPoint,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "PhoneNumber": phoneNumber,
        "isMale": isMale,
        "isDoctor": isDoctor,
        "isStudent": isStudent,
        "isPatient": isPatient,
      },
    );
    if (response.statusCode == 200) {
      RegisterBodyModel model = RegisterBodyModel.fromJson(response.data);
      return model;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddedBody> signUpDoctor(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool isMale,
      required bool isDoctor,
      required String academicYear,
      required String GPA,
      required String clinicGovernment,
      required String clinicCity,
      required String clinicStreet,
      required String clinicFloor,
      required String other,
      required String password,
        required String universityName,
        required String gradDate,
      }) async {
    Response response = await apiConsumer.post(
      EndPoints.addDoctorEndPoint,
      queryParameters: {'IsDoctor':true},
      data:{
        "firstName": fName,
        "lastName": sName,
        "email": email,
        "isMale": isMale,
        "phoneNumber": phone,
        "universityName": universityName,
        "clinicAddress": '$clinicGovernment - $clinicCity - $clinicStreet - $clinicFloor',
        "clinicNumber": null,
        ///TODO : here
        "insuranceCompanies": [
          "test" , "Doctor" , "Doctor"
        ],
        "certificates": [
          "string" , "Doctor" , "Doctor"
        ],
        "gpa": GPA,
        "birthDate":dob,
        "graduationDate": gradDate,
      },
    );
    if (response.statusCode == 200) {
      AddedBodyModel model = AddedBodyModel.fromJson(response.data);
      return model;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AddedBody> signUpPatient(
      {required String fName,
      required String sName,
      required String email,
      required String phone,
      required String dob,
      required bool isMale,
      required String government,
      required String city}) async {
    Response response = await apiConsumer.post(
      EndPoints.addPatientEndPoint,
      queryParameters: {'IsPatient': true},
      data: {
        "FirstName": fName,
        "LastName": sName,
        "email": email,
        "isMale": isMale,
        "phoneNumber": phone,

        ///TODO : HERE this code for address
        "address": null,
        "government": government,
        "city": city,
        "insuranceCompany": null,

        ///TODO : here this code for  insurance company
        "birthDate": dob,
      },
    );
    if (response.statusCode == 200) {
      AddedBody addedBody = AddedBodyModel.fromJson(response.data);
      return addedBody;
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
    Response response = await apiConsumer.post(
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
