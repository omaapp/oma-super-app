import 'package:flutter/material.dart';

class ComingSoonSection extends StatelessWidget {
  const ComingSoonSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "قريباً في OMA",
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

              _ComingCard(
                icon: Icons.delivery_dining,
                title: "توصيل الطعام",
                color: Colors.red,
              ),

              _ComingCard(
                icon: Icons.shopping_bag,
                title: "المتجر",
                color: Colors.blue,
              ),

              _ComingCard(
                icon: Icons.local_shipping,
                title: "توصيل الطلبات",
                color: Colors.orange,
              ),

              _ComingCard(
                icon: Icons.electric_bolt,
                title: "شحن الرصيد",
                color: Colors.green,
              ),

              _ComingCard(
                icon: Icons.medical_services,
                title: "الصيدليات",
                color: Colors.purple,
              ),

              _ComingCard(
                icon: Icons.more_horiz,
                title: "المزيد",
                color: Colors.teal,
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
  final String title;
  final Color color;

  const _ComingCard({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(22),

      onTap: () {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(
            content: Text(
              "$title قريباً",
            ),
          ),
        );
      },

      child: Container(

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

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            CircleAvatar(

              radius: 28,

              backgroundColor:
                  color.withOpacity(.12),

              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: const Text(
                "قريباً",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}