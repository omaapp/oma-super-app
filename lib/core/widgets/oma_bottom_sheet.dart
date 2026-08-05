import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class OmaBottomSheet {
  OmaBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool scrollControlled = true,
    bool enableDrag = true,
    bool isDismissible = true,
    EdgeInsetsGeometry padding =
        const EdgeInsets.fromLTRB(20, 12, 20, 24),
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: scrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (_) {
        final dark =
            Theme.of(context).brightness == Brightness.dark;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: dark
                ? AppColors.darkCard
                : AppColors.lightCard,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 25,
                offset: Offset(0, -6),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 55,
                    height: 5,
                    decoration: BoxDecoration(
                      color: dark
                          ? Colors.white24
                          : Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(100),
                    ),
                  ),

                  const SizedBox(height: 18),

                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}