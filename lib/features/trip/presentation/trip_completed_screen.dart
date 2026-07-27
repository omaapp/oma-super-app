import 'package:flutter/material.dart';

class TripCompletedScreen extends StatelessWidget {
  final String tripId;

  const TripCompletedScreen({
    super.key,
    required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 140,
                  height: 140,

                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 90,
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "تم إنهاء الرحلة",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "شكراً لاستخدام Oma\nنتمنى أن تكون رحلتك ممتعة.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 45),
                                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.star),
                    label: const Text(
                      "تقييم السائق",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      // سيتم ربط شاشة التقييم لاحقاً
                    },
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.home),
                    label: const Text(
                      "العودة للرئيسية",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/home",
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}