import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/oma_bottom_sheet.dart';
import '../../../../../core/widgets/oma_card.dart';

import '../../../../notifications/presentation/widgets/notification_badge.dart';
import '../../../../settings/presentation/home_settings_sheet.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "صباح الخير ☀️";
    } else if (hour < 17) {
      return "نهارك سعيد 🌤";
    } else {
      return "مساء الخير 🌙";
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [

        //-------------------------------------------------
        // Header
        //-------------------------------------------------

        Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                "assets/profile/default_avatar.png",
                width: 58,
                height: 58,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    _greeting(),
                    style: AppTextStyles.caption,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "مرحباً بك",
                    style: AppTextStyles.heading,
                  ),
                ],
              ),
            ),

            const NotificationBadge(),

            const SizedBox(width: 10),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.settings_rounded,
                ),
                onPressed: () {

                  OmaBottomSheet.show(
                    context: context,
                    child: const HomeSettingsSheet(),
                  );

                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        //-------------------------------------------------
        // Location Card
        //-------------------------------------------------

        OmaCard(
          child: Row(
            children: [

              Container(
                width: 54,
                height: 54,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: dark
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: Image.asset(
                  "assets/branding/logo.png",
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      "موقعك الحالي",
                      style:
                          AppTextStyles.caption,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "الرفاعي • ذي قار",
                      style:
                          AppTextStyles.body.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  "تغيير",
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
