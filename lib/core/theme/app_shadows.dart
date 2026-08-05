import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  /// Shadow خفيف للبطاقات الصغيرة
  static final List<BoxShadow> sm = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Shadow افتراضي لمعظم عناصر التطبيق
  static final List<BoxShadow> md = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  /// Shadow قوي للنوافذ والـ BottomSheets
  static final List<BoxShadow> lg = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 28,
      spreadRadius: 1,
      offset: const Offset(0, 12),
    ),
  ];

  // توافق مع الملفات القديمة
  static List<BoxShadow> get card => md;
  static List<BoxShadow> get heavy => lg;
}