import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/Auth/domain/entities/added.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';

class SignUpStudentUseCase {
  final AuthRepository authRepository;

  SignUpStudentUseCase({required this.authRepository});

  Future<Either<Failure, AddedBody>> signUpStudent({
    required String fName,
    required String sName,
    required String email,
    required String phone,
    required String dob,
    required bool isMale,
    required bool isDoctor,
    required String academicYear,
    required String GPA,
    required String universityGovernment,
    required String universityName,
    required String universityCity,
    required String universityStreet,
    required String other,
    required String password,
  }) async =>
      await authRepository.signUpStudent(
        fName: fName,
        sName: sName,
        email: email,
        phone: phone,
        dob: dob,
        isMale: isMale,
        isDoctor: isDoctor,
        academicYear: academicYear,
        GPA: GPA,
        universityGovernment: universityGovernment,
        universityCity: universityCity,
        universityStreet: universityStreet,
        other: other,
        password: password,
        universityName: universityName,
      );
}
