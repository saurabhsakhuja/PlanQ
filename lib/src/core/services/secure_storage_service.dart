import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _flutterSecureStorage;

  SecureStorageService(this._flutterSecureStorage);

  Future write(String key, String value) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _flutterSecureStorage.read(key: key);
  }

  Future<bool> containsKey(String key) async {
    return await _flutterSecureStorage.containsKey(key: key);
  }

  Future delete(String key) async {
    await _flutterSecureStorage.delete(key: key);
  }
}
