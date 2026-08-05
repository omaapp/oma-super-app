import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xff1565C0),
      Color(0xff1976D2),
      Color(0xff42A5F5),
    ],
  );

  static const card = LinearGradient(
    colors: [
      Colors.white,
      Color(0xffF8FAFF),
    ],
  );
}