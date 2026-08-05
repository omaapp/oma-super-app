import 'package:flutter/material.dart';

import '../../../map/presentation/map_screen.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

import 'animated_appear.dart';
import 'animated_vehicle_card.dart';

class QuickServices extends StatelessWidget {
  const QuickServices({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cardHeight =
        MediaQuery.of(context).size.width * .62;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "الخدمات",
                style: AppTextStyles.heading,
              ),

              const Spacer(),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary
                      .withValues(alpha: .10),
                  borderRadius:
                      BorderRadius.circular(
                    AppRadius.large,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.flash_on_rounded,
                      color: Colors.orange,
                      size: 18,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      "متاح الآن",
                      style:
                          AppTextStyles.caption.copyWith(
                        color:
                            AppColors.primary,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: cardHeight,
                  child: AnimatedAppear(
                    delay: const Duration(
                      milliseconds: 300,
                    ),
                    child: AnimatedVehicleCard(
                      title: "Taxi",
                      subtitle:
                          "سيارات مريحة لجميع رحلاتك",
                      icon:
                          Icons.local_taxi_rounded,
                      color:
                          AppColors.primary,
                      badge: "الأكثر طلباً",
                      eta: "3-5 دقائق",
                      rating: "4.9",
                      price:
                          "ابتداءً من 2000 د.ع",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MapScreen(
                              initialVehicle:
                                  "taxi",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: SizedBox(
                  height: cardHeight,
                  child: AnimatedAppear(
                    delay: const Duration(
                      milliseconds: 450,
                    ),
                    child: AnimatedVehicleCard(
                      title: "Tuk Tuk",
                      subtitle:
                          "تنقل سريع داخل المدينة",
                      icon: Icons
                          .electric_rickshaw,
                      color:
                          AppColors.secondary,
                      badge: "اقتصادي",
                      eta: "2-4 دقائق",
                      rating: "4.8",
                      price:
                          "ابتداءً من 1000 د.ع",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MapScreen(
                              initialVehicle:
                                  "tuk",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 36,
          ),

          Text(
            "قريباً",
            style: AppTextStyles.heading,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: cardHeight,
                  child: AnimatedAppear(
                    delay: const Duration(
                      milliseconds: 600,
                    ),
                    child: AnimatedVehicleCard(
                      title: "Delivery",
                      subtitle:
                          "توصيل الطلبات",
                      icon:
                          Icons.delivery_dining,
                      color:
                          AppColors.success,
                      badge: "قريباً",
                      eta: "--",
                      rating: "--",
                      price: "--",
                      onTap: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "ستتوفر قريباً",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: SizedBox(
                  height: cardHeight,
                  child: AnimatedAppear(
                    delay: const Duration(
                      milliseconds: 750,
                    ),
                    child: AnimatedVehicleCard(
                      title: "Courier",
                      subtitle:
                          "إرسال الطرود",
                      icon:
                          Icons.inventory_2,
                      color:
                          Colors.deepPurple,
                      badge: "قريباً",
                      eta: "--",
                      rating: "--",
                      price: "--",
                      onTap: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "ستتوفر قريباً",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}