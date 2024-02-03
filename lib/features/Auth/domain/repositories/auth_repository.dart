import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> signUpPatient({
    required String fName,
    required String sName,
    required String email,
    required String phone,
    required String dob,
    required bool gender,
    required String government,
    required String city,
  });

  Future<Either<Failure, Unit>> signUpStudent({
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

  Future<Either<Failure, Unit>> signUpDoctor({
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
