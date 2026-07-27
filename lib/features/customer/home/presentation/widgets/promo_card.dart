import 'package:flutter/material.dart';

import '../../../map/presentation/map_screen.dart';
import 'glass_card.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
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
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.blue.shade100,
                child: const Icon(
                  Icons.discount,
                  color: Color(0xff1565C0),
                  size: 35,
                ),
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
  "عروض خاصة",
  style: AppTextStyles.heading,
),

const SizedBox(
  height: 8,
),

Text(
  "اضغط هنا لبدء رحلتك والاستفادة من أحدث العروض.",
  style: AppTextStyles.subtitle,
),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff1565C0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}