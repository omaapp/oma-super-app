import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'oma_card.dart';
import 'primary_button.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  final String? buttonText;
  final VoidCallback? onPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 30,
        ),
        child: OmaCard(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 34,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: .10,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 26),

              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading.copyWith(
                  color: isDark
                      ? Colors.white
                      : AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle.copyWith(
                  height: 1.6,
                ),
              ),

              if (buttonText != null &&
                  onPressed != null) ...[
                const SizedBox(height: 30),

                PrimaryButton(
                  text: buttonText!,
                  icon: Icons.refresh_rounded,
                  onPressed: onPressed,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}