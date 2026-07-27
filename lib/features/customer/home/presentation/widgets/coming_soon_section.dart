import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ComingSoonSection extends StatelessWidget {
  const ComingSoonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "قريباً في Oma",
            style: AppTextStyles.title,
          ),

          const SizedBox(height: AppSpacing.lg),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: .95,
            children: const [
              _ComingCard(
                icon: Icons.delivery_dining,
                color: Colors.deepOrange,
                title: "توصيل الطلبات",
                subtitle: "استلم طلباتك بسرعة",
              ),

              _ComingCard(
                icon: Icons.shopping_bag,
                color: Colors.green,
                title: "التسوق",
                subtitle: "شراء الاحتياجات اليومية",
              ),

              _ComingCard(
                icon: Icons.local_pharmacy,
                color: Colors.red,
                title: "الصيدليات",
                subtitle: "توصيل الأدوية",
              ),

              _ComingCard(
                icon: Icons.restaurant,
                color: Colors.amber,
                title: "المطاعم",
                subtitle: "اطلب وجبتك المفضلة",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComingCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _ComingCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "$title ستكون متوفرة قريباً",
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: color.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 34,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.subtitle.copyWith(
                height: 1.4,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "قريباً",
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}