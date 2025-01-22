import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constant/app_constant.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  final GetStorage _storage = GetStorage();

  ThemeNotifier() {
    _loadTheme();
  }

  void toggleDark() {
    _themeData = ThemeData.dark();
    _themeMode = ThemeMode.dark;
    notifyListeners();
    _saveThemePreference(2);
  }

  void toggleLight() {
    _themeData = ThemeData.light();
    _themeMode = ThemeMode.light;
    notifyListeners();
    _saveThemePreference(1);
  }

  void useSystemTheme() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _themeData =
    brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();
    _themeMode = ThemeMode.system;
    notifyListeners();
    _saveThemePreference(0);
  }

  void _saveThemePreference(int themeIndex) {
    _storage.write(AppConstants.themeModeKey, themeIndex);
  }

  void _loadTheme() {
    int themeIndex = _storage.read(AppConstants.themeModeKey) ?? 0;
    switch (themeIndex) {
      case 0:
        useSystemTheme();
        break;
      case 1:
        toggleLight();
        break;
      case 2:
        toggleDark();
        break;
    }
  }

  int getCurrentTheme(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.dark:
        return 2;
      case ThemeMode.light:
        return 1;
      case ThemeMode.system:
        return 0;
      default:
        return 0;
    }
  }
}