import 'package:flutter/material.dart';

class WhyOmaSection extends StatelessWidget {
  const WhyOmaSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "لماذا OMA ؟",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: .95,

            children: const [

              _FeatureCard(
                icon: Icons.flash_on,
                title: "استجابة سريعة",
                subtitle: "أقرب سائق يصل إليك خلال دقائق",
                color: Colors.orange,
              ),

              _FeatureCard(
                icon: Icons.security,
                title: "رحلات آمنة",
                subtitle: "جميع السائقين موثقون",
                color: Colors.green,
              ),

              _FeatureCard(
                icon: Icons.payments,
                title: "أسعار واضحة",
                subtitle: "السعر يظهر قبل تأكيد الرحلة",
                color: Colors.blue,
              ),

              _FeatureCard(
                icon: Icons.support_agent,
                title: "دعم 24/7",
                subtitle: "فريق دعم جاهز دائماً",
                color: Colors.deepPurple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

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

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          CircleAvatar(

            radius: 24,

            backgroundColor: color.withValues(alpha: .12),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const Spacer(),

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
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}