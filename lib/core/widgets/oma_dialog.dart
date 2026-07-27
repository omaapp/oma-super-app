import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'danger_button.dart';
import 'primary_button.dart';

class OmaDialog {
  OmaDialog._();

  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "تأكيد",
    String cancelText = "إلغاء",
    bool danger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),

          title: Text(
            title,
            style: AppTextStyles.title,
          ),

          content: Text(
            message,
            style: AppTextStyles.body,
          ),

          actionsPadding: const EdgeInsets.all(18),

          actions: [

            PrimaryButton(
              text: confirmText,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),

            const SizedBox(height: 10),

            if (danger)

              DangerButton(
                text: cancelText,
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )

            else

              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  cancelText,
                  style: const TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}