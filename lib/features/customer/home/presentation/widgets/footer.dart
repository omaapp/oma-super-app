import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        10,
        18,
        30,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 14,
              offset: Offset(0,6),
            ),
          ],
        ),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 34,
              backgroundColor: Color(0xff1565C0),
              child: Icon(
                Icons.local_taxi,
                color: Colors.white,
                size: 36,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "OMA",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Taxi • Tuk Tuk • Super App",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 26),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [

                _FooterButton(
                  icon: Icons.phone,
                  title: "اتصل بنا",
                  color: Colors.green,
                ),

                _FooterButton(
                  icon: Icons.facebook,
                  title: "Facebook",
                  color: Colors.blue,
                ),

                _FooterButton(
                  icon: Icons.telegram,
                  title: "Telegram",
                  color: Colors.lightBlue,
                ),

                _FooterButton(
                  icon: Icons.language,
                  title: "الموقع",
                  color: Colors.deepPurple,
                ),
              ],
            ),

            const SizedBox(height: 26),

            Divider(),

            const SizedBox(height: 14),

            Text(
              "الإصدار 1.0.0",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "© 2026 OMA",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {

  final IconData icon;
  final String title;
  final Color color;

  const _FooterButton({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(18),

      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(title),
          ),
        );
      },

      child: Column(

        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor:
                color.withValues(alpha: .12),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}