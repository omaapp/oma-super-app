import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  final double height;
  final double width;

  final double borderRadius;

  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;

  final bool enabled;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.height = 56,
    this.width = double.infinity,
    this.borderRadius = AppRadius.md,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark =
        Theme.of(context).brightness == Brightness.dark;

    final Color border =
        borderColor ?? AppColors.primary;

    final Color txt =
        textColor ?? AppColors.primary;

    final Color icn =
        iconColor ?? txt;

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          foregroundColor: txt,
          side: BorderSide(
            color: border,
            width: 1.5,
          ),
          disabledForegroundColor:
              txt.withValues(alpha: .45),
          disabledBackgroundColor: dark
              ? AppColors.darkCard
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: enabled
                    ? icn
                    : icn.withValues(alpha: .45),
                size: 20,
              ),
              const SizedBox(
                width: AppSpacing.sm,
              ),
            ],
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style:
                    AppTextStyles.buttonDark.copyWith(
                  color: enabled
                      ? txt
                      : txt.withValues(alpha: .45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}