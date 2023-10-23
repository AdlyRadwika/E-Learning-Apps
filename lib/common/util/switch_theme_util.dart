import 'package:final_project/common/services/secure_storage_service.dart';
import 'package:flutter/material.dart';

class SwitchThemeProvider extends ChangeNotifier {
  final SecureStorageService _storage;

  SwitchThemeProvider(this._storage);

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> initTheme() async {
    await _storage.getTheme().then((value) {
      if (value == ThemeMode.system.name) {
        _themeMode = ThemeMode.system;
      } else if (value == ThemeMode.light.name) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.dark;
      }
    });
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) {
    _themeMode = theme;
    _storage.saveThemeData(value: theme.name);
    notifyListeners();
  }
}
