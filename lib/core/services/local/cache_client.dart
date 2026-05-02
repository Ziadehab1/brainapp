import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheClient {
  CacheClient(this._prefs) : _secureStorage = const FlutterSecureStorage();

  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  // SharedPreferences — non-sensitive data
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setBool(String key, {required bool value}) =>
      _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  Future<bool> remove(String key) => _prefs.remove(key);

  Future<bool> clear() => _prefs.clear();

  // FlutterSecureStorage — sensitive data (tokens, credentials)
  Future<void> setSecureString(String key, String value) =>
      _secureStorage.write(key: key, value: value);

  Future<String?> getSecureString(String key) =>
      _secureStorage.read(key: key);

  Future<void> deleteSecure(String key) => _secureStorage.delete(key: key);

  Future<void> clearSecure() => _secureStorage.deleteAll();
}