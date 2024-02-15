import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';

import '../../data/models/register_body_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, RegisterBodyModel>> newRegister({
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
    List<String>? clinicAddress,
    List<String>? insuranceCompanies,
    List<String>? certificates,
    String? clinicNumber,
    double? gpa,
    String? birthDate,
    String? graduationDate,
    List<String>? address,
    String? insuranceCompany,
    List<String>? universitAddress,
    int? academicYear,
  });


}
