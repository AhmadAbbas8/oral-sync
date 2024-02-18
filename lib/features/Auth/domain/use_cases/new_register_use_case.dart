import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/Auth/data/models/register_body_model.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';

class NewRegisterUseCase {
  final AuthRepository authRepository;

  NewRegisterUseCase({required this.authRepository});

  Future<Either<Failure, RegisterBodyModel>> call({
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
  }) async {
    return await authRepository.newRegister(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isMale: isMale,
      phoneNumber: phoneNumber,
      isDoctor: isDoctor,
      isStudent: isStudent,
      isPatient: isPatient,
      fName: fName,
      lName: lName,
      universityName: universityName,
      academicYear: academicYear,
      address: address,
      birthDate: birthDate,
      certificates: certificates,
      clinicAddress: clinicAddress,
      clinicNumber: clinicNumber,
      gpa: gpa,
      graduationDate: graduationDate,
      insuranceCompanies: insuranceCompanies,
      insuranceCompany: insuranceCompany,
      universitAddress: universitAddress,
    );
  }
}
