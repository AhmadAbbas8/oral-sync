import 'package:dartz/dartz.dart';
abstract class AuthRemoteDataSource {
  Future<Unit> login({
    required String email,
    required String password,
  });
  Future< Unit> register({
    required String fName,
    required String sName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required bool isMale,
    required bool isDoctor,
    required bool isStudent,
    required bool isPatient,
  });

  Future<Unit> signUpPatient({
    required String fName,
    required String sName,
    required String email,
    required String phone,
    required String dob,
    required bool gender,
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

  Future<Unit> signUpDoctor({
    required String fName,
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
    required String password,
  });
}
