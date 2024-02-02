import 'package:oralsync/core/cache_helper/cache_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsCache implements CacheStorage {
  final SharedPreferences _prefs;

  const SharedPrefsCache(this._prefs);

  @override
  Future<bool> setData<T>({required String key, required T value}) {
    switch (T) {
      case bool:
        return _prefs.setBool(key, value as bool);
      case double:
        return _prefs.setDouble(key, value as double);
      case int:
        return _prefs.setInt(key, value as int);

      case String:
        return _prefs.setString(key, value as String);
      case const (List<String>):
        return _prefs.setStringList(key, value as List<String>);
      default:
        throw Exception('Type not supported');
    }
  }

  @override
  T? getData<T>({required String key}) {
    return _prefs.get(key) as T?;
  }

  @override
  bool hasData({required String key}) {
    return _prefs.containsKey(key);
  }

  @override
  Future<bool> removeData({required String key}) {
    return _prefs.remove(key);
  }

  @override
  Future<bool> removeAllData() {
    return _prefs.clear();
  }
}
