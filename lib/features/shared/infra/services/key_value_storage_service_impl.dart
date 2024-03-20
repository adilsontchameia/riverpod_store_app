import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/infra/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> setKeyValu<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        prefs.setInt(key, value);
        break;
      case String:
        prefs.setString(key, value);
        break;

      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}',
        );
    }
  }

  @override
  Future<T?> getKeyValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;

      case String:
        return prefs.getString(key) as T?;

      default:
        throw UnimplementedError(
          'Get not implemented for type ${T.runtimeType}',
        );
    }
  }

  @override
  Future<bool> removeKeyValue(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }
}
