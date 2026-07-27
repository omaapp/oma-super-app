import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static final title = GoogleFonts.cairo(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final heading = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final body = GoogleFonts.cairo(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static final subtitle = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade700,
  );

  static final button = GoogleFonts.cairo(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final caption = GoogleFonts.cairo(
    fontSize: 13,
    color: Colors.grey,
  );
}