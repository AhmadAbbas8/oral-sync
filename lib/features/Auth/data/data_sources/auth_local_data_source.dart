import 'package:oralsync/features/Auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> cacheUser({required UserModel userModel});

  Future<bool> cacheToken({required String token});
  Future<bool> logout();
}
