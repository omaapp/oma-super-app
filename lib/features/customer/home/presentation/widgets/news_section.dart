import 'package:flutter/material.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "آخر الأخبار",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          const _NewsCard(
            title: "إطلاق خدمة Taxi الجديدة",
            subtitle:
                "أصبح بإمكانك طلب سيارة خلال دقائق داخل الرفاعي.",
            icon: Icons.local_taxi,
            color: Color(0xff1565C0),
          ),

          SizedBox(height: 16),

          _NewsCard(
            title: "خصومات نهاية الأسبوع",
            subtitle:
                "استمتع بخصومات تصل إلى 30% على جميع الرحلات.",
            icon: Icons.discount,
            color: Colors.orange,
          ),

          SizedBox(height: 16),

          _NewsCard(
            title: "إضافة سائقين جدد",
            subtitle:
                "تم توسيع أسطول السائقين لتقليل وقت الانتظار.",
            icon: Icons.people,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _NewsCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(22),

      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(title),
          ),
        );
      },

      child: Container(

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(22),

          boxShadow: const [

            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 14,
              offset: Offset(0,6),
            ),
          ],
        ),

        child: Row(

          children: [

            CircleAvatar(

              radius: 30,

              backgroundColor:
                  color.withValues(alpha: .12),

              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}