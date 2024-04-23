
import 'package:oralsync/features/Auth/data/models/register_body_model.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<RegisterBodyModel> register({
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
    String? governorate,
    List<String>? universityAddress,
    int? academicYear,
  });

}
