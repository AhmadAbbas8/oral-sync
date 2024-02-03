import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call({
    required String email,
    required String password,
  }) async =>
     await authRepository.login(email: email, password: password);
}
