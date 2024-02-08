// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:oralsync/features/Auth/data/models/register_body_model.dart';
import 'package:oralsync/features/Auth/domain/entities/added.dart';
import 'package:oralsync/features/Auth/domain/entities/user.dart';
abstract class AuthRemoteDataSource {
  Future<User> login({
    required String email,
    required String password,
  });
  Future< RegisterBodyModel> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String confirmPassword,
    required bool isMale,
    required bool isDoctor,
    required bool isStudent,
    required bool isPatient,
  });

  Future<AddedBody> signUpPatient({
    required String fName,
    required String sName,
    required String email,
    required String phone,
    required String dob,
    required bool isMale,
    required String government,
    required String city,
  });

  Future<Unit> signUpStudent({
    required String fName,
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
    required String password,
  });

  Future<AddedBody> signUpDoctor({
    required String fName,
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
  });
}
