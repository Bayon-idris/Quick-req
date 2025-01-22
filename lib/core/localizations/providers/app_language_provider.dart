import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constant/app_constant.dart';

class AppLanguageNotifier extends ChangeNotifier {
  Locale _appLocale = PlatformDispatcher.instance.locale;

  AppLanguageNotifier() {
    fetchLocale();
  }

  Locale get appLocale => _appLocale;

  Future<void> fetchLocale() async {
    var storage = GetStorage();

    String? languageCode = storage.read<String>(AppConstants.languageCodeKey);
    if (languageCode != null) {
      _appLocale = Locale(languageCode);
    }

    notifyListeners();
  }

  Future<void> changeLanguage(Locale type) async {
    var storage = GetStorage();

    if (_appLocale == type) {
      return;
    }

    _appLocale = type;
    await storage.write(AppConstants.languageCodeKey, type.languageCode);
    await storage.write(AppConstants.countryCodeKey, type.countryCode);

    notifyListeners();
  }
}

final appLanguageProvider = ChangeNotifierProvider<AppLanguageNotifier>((ref) {
  return AppLanguageNotifier();
});