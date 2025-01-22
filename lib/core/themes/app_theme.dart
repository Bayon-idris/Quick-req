import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';

class AppTheme {
  // Light theme
  static final lightTheme = ThemeData(
    fontFamily: FontFamily.varelaRound,
    scaffoldBackgroundColor: const Color(0xFFF4F5F6),
    useMaterial3: true,
    primaryColor: const Color(0xFFF78E00),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFe55100),
      secondary: Colors.grey,
      onSurface: Colors.black,
      onPrimary: const Color(0xFFEDEDEF),
    ),
  );

  // Dark theme
  static final darkTheme = ThemeData(
    fontFamily: FontFamily.varelaRound,
    scaffoldBackgroundColor: const Color(0xFF141416),
    useMaterial3: true,
    primaryColor: const Color(0xFFF78E00),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFe55100),
      secondary: Colors.grey,
      onSurface: Colors.white,
      onPrimary: const Color(0xFF2E313A),
    ),
  );
}