import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/oma_card.dart';
import '../../../../../core/widgets/primary_button.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OmaCard(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
            ],
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      "مرحباً بك 👋",
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "إلى أين تريد الذهاب اليوم؟",
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "اطلب سيارة أو تكتك خلال ثوانٍ واستمتع برحلة آمنة وسريعة داخل العراق.",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: .90),
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: 170,
                      child: PrimaryButton(
                        text: "اطلب رحلة",
                        icon: Icons.arrow_forward_rounded,
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 18),

              Hero(
                tag: "oma_taxi",
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .15),
                    borderRadius:
                        BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.local_taxi_rounded,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
