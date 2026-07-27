import 'package:flutter/material.dart';

class OmaSnackbar {
  OmaSnackbar._();

  static void success(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }

  static void error(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }

  static void info(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}