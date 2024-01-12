abstract class KeyValueStorageService {
  Future<T?> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key, T value);
  Future<bool> removeKey(String key);
}
