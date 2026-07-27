import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xff1565C0);
  static const Color secondary = Color(0xff42A5F5);
  static const Color accent = Color(0xffFFC107);

  static const Color success = Color(0xff2E7D32);
  static const Color danger = Color(0xffD32F2F);
  static const Color error = danger;

  // الخلفيات
  static const Color background = Color(0xffF5F7FA);
  static const Color darkBackground = Color(0xff121212);

  // البطاقات
  static const Color card = Colors.white;
  static const Color darkCard = Color(0xff1E1E1E);
  static const Color darkSurface = darkCard;

  // الحدود
  static const Color border = Color(0xffE0E0E0);
  static const Color divider = border;

  // النصوص
  static const Color textPrimary = Color(0xff212121);
  static const Color textSecondary = Color(0xff757575);

  // توافق مع الأسماء القديمة
  static const Color lightBackground = background;
  static const Color lightCard = card;
}