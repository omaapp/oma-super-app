import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/oma_card.dart';
import '../../../../../core/widgets/primary_button.dart';

import '../../../map/presentation/map_screen.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness == Brightness.dark;

    return OmaCard(
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
              AppColors.primaryLight,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [

              //----------------------------------
              // Header
              //----------------------------------

              Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "رحلتك تبدأ هنا",
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "اطلب Taxi أو Tuk Tuk\nبضغطة واحدة",
                          style: AppTextStyles.title.copyWith(
                            color: Colors.white,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Hero(
                    tag: "hero_taxi",
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .15),
                        borderRadius:
                            BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.local_taxi_rounded,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              //----------------------------------
              // Search
              //----------------------------------

              InkWell(
                borderRadius:
                    BorderRadius.circular(18),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const MapScreen(),
                    ),
                  );

                },
                child: Container(
                  height: 62,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    color: dark
                        ? AppColors.darkCard
                        : Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [

                      const Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          "إلى أين تريد الذهاب؟",
                          style: AppTextStyles.body.copyWith(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              //----------------------------------
              // Quick addresses
              //----------------------------------

              Row(
                children: [

                  Expanded(
                    child: _MiniCard(
                      icon: Icons.home_rounded,
                      title: "المنزل",
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: _MiniCard(
                      icon: Icons.work_rounded,
                      title: "العمل",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              //----------------------------------
              // Button
              //----------------------------------

              PrimaryButton(
                text: "ابدأ رحلة الآن",
                icon: Icons.local_taxi_rounded,
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const MapScreen(),
                    ),
                  );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _MiniCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 16),

      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .16),
        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
