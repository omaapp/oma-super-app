import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //================ Brand =================

  static const Color primary = Color(0xFF1565C0);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF42A5F5);

  static const Color secondary = Color(0xFF00BFA5);

  //================ Status =================

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF0288D1);

  //================ Light Theme =================

  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Colors.white;
  static const Color lightCard = Colors.white;

  //================ Dark Theme =================

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1B1B1B);
  static const Color darkCard = Color(0xFF202124);

  //================ Text =================

  static const Color textPrimary = Color(0xFF202124);
  static const Color textSecondary = Color(0xFF616161);
  static const Color hint = Color(0xFF9E9E9E);

  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(0xFFBDBDBD);

  //================ Divider =================

  static const Color divider = Color(0xFFE0E0E0);

  //================ Others =================

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  //================ Compatibility =================

  // حتى لا تظهر أخطاء في الملفات القديمة
  static const Color background = lightBackground;
  static const Color surface = lightSurface;
  static const Color card = lightCard;
  static const Color danger = error;
}