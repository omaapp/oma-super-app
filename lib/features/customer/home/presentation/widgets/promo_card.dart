import 'package:flutter/material.dart';

import '../../../map/presentation/map_screen.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

import '../../../../../core/widgets/glass_card.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          AppRadius.large,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MapScreen(
                initialVehicle: "taxi",
              ),
            ),
          );
        },
        child: GlassCard(
          child: Row(
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: .12,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.large,
                  ),
                ),
                child: const Icon(
                  Icons.discount_rounded,
                  color: AppColors.primary,
                  size: 38,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "العروض الحصرية",
                      style: AppTextStyles.heading,
                    ),

                    const SizedBox(
                      height: AppSpacing.sm,
                    ),

                    Text(
                      "استمتع بخصومات وعروض جديدة على رحلات Taxi و Tuk Tuk داخل المدينة.",
                      style: AppTextStyles.subtitle,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                AppColors.success.withValues(
                              alpha: .12,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Text(
                            "خصومات يومية",
                            style:
                                AppTextStyles.caption.copyWith(
                              color:
                                  AppColors.success,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                AppColors.secondary.withValues(
                              alpha: .12,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: Text(
                            "عروض جديدة",
                            style:
                                AppTextStyles.caption.copyWith(
                              color:
                                  AppColors.secondary,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(
                    14,
                  ),
                  boxShadow: AppShadows.card,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}