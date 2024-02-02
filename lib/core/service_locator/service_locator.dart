import 'package:get_it/get_it.dart';
import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:oralsync/core/cache_helper/shared_prefs_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  ServiceLocator._();

  static final instance = GetIt.instance;

  static Future<void> setup() async {
    // * Cache Storage
    final prefs = await SharedPreferences.getInstance();
    instance.registerSingleton<CacheStorage>(SharedPrefsCache(prefs));
  }
}
