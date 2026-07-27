import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static final card = [
    BoxShadow(
      color: Colors.black.withOpacity(.06),
      blurRadius: 14,
      offset: const Offset(0, 6),
    ),
  ];

  static final heavy = [
    BoxShadow(
      color: Colors.black.withOpacity(.12),
      blurRadius: 24,
      spreadRadius: 2,
      offset: const Offset(0, 10),
    ),
  ];
}