import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 210,

      margin: const EdgeInsets.symmetric(horizontal: 18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        gradient: const LinearGradient(
          colors: [
            Color(0xff1565C0),
            Color(0xff42A5F5),
          ],
        ),
      ),

      child: Stack(
        children: [

          Positioned(
            right: -30,
            bottom: 0,
            child: Image.asset(
              "assets/images/taxi.png",
              height: 170,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: const [

                Text(
                  "Oma",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  "تنقل بسرعة وأمان",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                Spacer(),

                Text(
                  "Taxi & Tuk Tuk",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}