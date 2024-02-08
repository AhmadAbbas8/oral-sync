import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';
import 'package:oralsync/features/Auth/domain/entities/register.dart';
import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failure, RegisterBody>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required bool isMale,
    required bool isDoctor,
    required bool isStudent,
    required bool isPatient,
  }) async =>
      await authRepository
        .register(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
          isMale: isMale,
          isDoctor: isDoctor,
          isStudent: isStudent,
          isPatient: isPatient,
        );
}
