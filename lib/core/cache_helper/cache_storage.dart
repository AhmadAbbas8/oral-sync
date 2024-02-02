abstract class CacheStorage {
  Future<bool> setData<T>({required String key, required T value});
  T? getData<T>({required String key});
  bool hasData({required String key});
  Future<bool> removeData({required String key});
  Future<bool> removeAllData();
}
