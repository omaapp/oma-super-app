import 'package:flutter/material.dart';

class OmaBottomSheet {
  OmaBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool scrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: scrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            top: false,
            child: child,
          ),
        );
      },
    );
  }
}