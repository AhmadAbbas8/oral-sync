import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/Auth/domain/entities/added.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';

class SignUpPatientUseCase {
  final AuthRepository authRepository;

  SignUpPatientUseCase({required this.authRepository});

  Future<Either<Failure, AddedBody>> signUpPatient({
    required String fName,
    required String sName,
    required String email,
    required String phone,
    required String dob,
    required bool isMale,
    required String government,
    required String city,
  }) async =>
      authRepository.signUpPatient(
        fName: fName,
        sName: sName,
        email: email,
        phone: phone,
        dob: dob,
        isMale: isMale,
        government: government,
        city: city,
      );
}
