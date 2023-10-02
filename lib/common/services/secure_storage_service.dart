import 'dart:convert';

import 'package:final_project/features/domain/entities/register/register_form.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageInit {
  static FlutterSecureStorage getService() {
    return FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  static _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}

class SecureStorageService {
  final FlutterSecureStorage storage;

  SecureStorageService({required this.storage});

  static const _registerKey = 'register';
  Future<void> saveRegisterData({required RegisterData user}) async {
    await storage.write(
        key: _registerKey,
        value: jsonEncode({
          "email": user.email,
          "password": user.password,
          "name": user.name,
          "role": user.role,
        }));
  }

  Future<Map<String, dynamic>> getRegisterData() async {
    return json.decode(await storage.read(key: _registerKey) ?? "-");
  }

  void deleteRegisterData() {
    storage.delete(key: _registerKey);
  }
}
