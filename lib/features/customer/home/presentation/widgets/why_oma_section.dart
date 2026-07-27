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
            "لماذا Oma؟",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.15,
            children: const [

              _FeatureCard(
                icon: Icons.bolt,
                color: Colors.amber,
                title: "وصول سريع",
                subtitle: "اعثر على أقرب سائق خلال ثوانٍ.",
              ),

              _FeatureCard(
                icon: Icons.security,
                color: Colors.green,
                title: "رحلات آمنة",
                subtitle: "سائقون موثقون وتتبع مباشر.",
              ),

              _FeatureCard(
                icon: Icons.payments,
                color: Colors.blue,
                title: "أسعار مناسبة",
                subtitle: "أسعار واضحة بدون رسوم مخفية.",
              ),

              _FeatureCard(
                icon: Icons.location_searching,
                color: Colors.deepPurple,
                title: "تتبع مباشر",
                subtitle: "تابع السائق لحظة بلحظة.",
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

  final Color color;

  final String title;

  final String subtitle;

  const _FeatureCard({
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

        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: const [

          BoxShadow(
            blurRadius: 12,
            color: Colors.black12,
          )
        ],
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(.12),
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

          const SizedBox(height: 6),

          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}