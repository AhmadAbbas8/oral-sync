import 'dart:convert';

import 'package:oralsync/core/cache_helper/shared_prefs_keys.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:oralsync/features/Auth/data/models/user_model.dart';

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final CacheStorage cacheStorage;

  AuthLocalDataSourceImpl({required this.cacheStorage});

  @override
  Future<bool> cacheToken({required String token}) async =>
      await cacheStorage.setData(key: SharedPrefsKeys.token, value: token);

  @override
  Future<bool> cacheUser({required UserModel userModel}) async =>
      await cacheStorage.setData(
          key: SharedPrefsKeys.user, value: json.encode(userModel.toJson()));

  @override
  Future<bool> logout() async =>
      await cacheStorage.removeAllData();
}
