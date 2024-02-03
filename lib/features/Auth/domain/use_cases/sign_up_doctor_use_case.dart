import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';

class SignUpDoctorUseCase {
  final AuthRepository authRepository;

  SignUpDoctorUseCase({required this.authRepository});

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
  }) async =>
      authRepository.signUpDoctor(
          fName: fName,
          sName: sName,
          email: email,
          phone: phone,
          dob: dob,
          gender: gender,
          isDoctor: isDoctor,
          academicYear: academicYear,
          GPA: GPA,
          clinicGovernment: clinicGovernment,
          clinicCity: clinicCity,
          clinicStreet: clinicStreet,
          clinicFloor: clinicFloor,
          other: other,
          password: password);
}
