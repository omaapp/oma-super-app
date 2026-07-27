import 'package:flutter/material.dart';

import '../../../map/presentation/map_screen.dart';
import 'animated_vehicle_card.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
class QuickServices extends StatelessWidget {
  const QuickServices({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
  ),
  child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
  "الخدمات",
  style: AppTextStyles.title.copyWith(
    color: theme.colorScheme.onSurface,
  ),
),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.brightness ==
                          Brightness.dark
                      ? Colors.blue.withOpacity(.18)
                      : Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: Colors.orange,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "متاح الآن",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1565C0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
  children: [
    Expanded(
      child: SizedBox(
        height: 245,
        child: AnimatedVehicleCard(
  title: "Taxi",
  subtitle: "سيارات مريحة لجميع رحلاتك",
  icon: Icons.local_taxi,
  color: Colors.blue,
  badge: "الأكثر طلباً",
  eta: "3-5 دقائق",
  rating: "4.9",
  price: "ابتداءً من 2000 د.ع",
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
),
      ),
    ),

    const SizedBox(width: 18),

    Expanded(
      child: SizedBox(
        height: 245,
        child: AnimatedVehicleCard(
  title: "Tuk Tuk",
  subtitle: "تنقل سريع داخل المدينة",
  icon: Icons.electric_rickshaw,
  color: Colors.orange,
  badge: "اقتصادي",
  eta: "2-4 دقائق",
  rating: "4.8",
  price: "ابتداءً من 1000 د.ع",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MapScreen(
          initialVehicle: "tuk",
        ),
      ),
    );
  },
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