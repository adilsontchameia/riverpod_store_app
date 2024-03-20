abstract class KeyValueStorageService {
  Future<void> setKeyValu<T>(String key, T value);
  Future<T?> getKeyValue<T>(String key);
  Future<bool> removeKeyValue(String key);
}
