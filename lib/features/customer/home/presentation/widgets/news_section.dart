import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "آخر الأخبار",
          style: AppTextStyles.title,
        ),

        const SizedBox(height: 18),

        const _NewsCard(
          icon: Icons.campaign,
          color: Colors.blue,
          title: "إطلاق قريب",
          subtitle: "سيتم إطلاق خدمة النقل داخل المدينة قريبًا.",
        ),

        const SizedBox(height: 15),

        const _NewsCard(
          icon: Icons.local_offer,
          color: Colors.orange,
          title: "عروض قادمة",
          subtitle: "ترقب خصومات للمستخدمين الجدد.",
        ),

        const SizedBox(height: 15),

        const _NewsCard(
          icon: Icons.electric_rickshaw,
          color: Colors.green,
          title: "خدمة Tuk Tuk",
          subtitle: "ستتوفر قريبًا في جميع المناطق.",
        ),
      ],
    ),
    );
}

} // نهاية NewsSection

class _NewsCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _NewsCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
  color: Theme.of(context).cardColor,
  borderRadius: BorderRadius.circular(AppRadius.lg),
  boxShadow: AppShadows.card,
),

      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(.12),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.heading,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "جديد",
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  subtitle,
                  style: AppTextStyles.subtitle.copyWith(
  height: 1.5,
),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 18,
          ),
        ],
      ),
    );
  }
}