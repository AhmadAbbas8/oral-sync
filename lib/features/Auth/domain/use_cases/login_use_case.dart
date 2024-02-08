import 'package:oralsync/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:oralsync/core/error/failure.dart';

import '../entities/user.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async =>
     await authRepository.login(email: email, password: password);
}
