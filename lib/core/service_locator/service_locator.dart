import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_cache.dart';
import 'package:oralsync/core/network/network_info.dart';
import 'package:oralsync/core/utils/assets_manager.dart';
import 'package:oralsync/core/utils/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  ServiceLocator._();

  static final instance = GetIt.instance;

  static Future<void> setup() async {
    // * Core
    final prefs = await SharedPreferences.getInstance();
    instance.registerLazySingleton<CacheStorage>(() => SharedPrefsCache(prefs));
    instance
        .registerLazySingleton<NetworkInfo>(() => NetWorkInfoImpl(instance()));
    instance.registerLazySingleton(
      () => Dio(
        BaseOptions(
          validateStatus: (status) => status == 200,
          baseUrl: EndPoints.BASE_URL,
        ),
      ),
    );
  }
}
