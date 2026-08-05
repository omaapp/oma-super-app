import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginCard extends StatelessWidget {
  final Widget phoneField;
  final Widget continueButton;
  final Widget googleButton;
  final Widget appleButton;
  final Widget guestButton;

  const LoginCard({
    super.key,
    required this.phoneField,
    required this.continueButton,
    required this.googleButton,
    required this.appleButton,
    required this.guestButton,
  });

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: dark
            ? AppColors.darkCard
            : AppColors.lightCard,
        borderRadius: BorderRadius.circular(
          AppRadius.xl,
        ),
        border: Border.all(
          color: dark
              ? Colors.white10
              : AppColors.divider,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Text(
            "مرحباً بك 👋",
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
            ),
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Text(
            "سجل الدخول للاستمرار",
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle,
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          phoneField,

          const SizedBox(
            height: AppSpacing.lg,
          ),

          continueButton,

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Row(
            children: [
              Expanded(
                child: Divider(
                  color: dark
                      ? Colors.white12
                      : AppColors.divider,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                ),
                child: Text(
                  "أو",
                  style: AppTextStyles.label,
                ),
              ),

              Expanded(
                child: Divider(
                  color: dark
                      ? Colors.white12
                      : AppColors.divider,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          googleButton,

          const SizedBox(
            height: AppSpacing.md,
          ),

          appleButton,

          const SizedBox(
            height: AppSpacing.lg,
          ),

          guestButton,
        ],
      ),
    );
  }
}