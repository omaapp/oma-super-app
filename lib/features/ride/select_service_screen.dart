import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectServiceScreen extends StatelessWidget {
  const SelectServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "اختر الخدمة",
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            Text(
              "إلى أين تريد الذهاب؟",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "اختر نوع وسيلة النقل",
              style: GoogleFonts.cairo(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            Expanded(
              child: Row(
                children: [

                  Expanded(
                    child: _serviceCard(
                      icon: Icons.local_taxi,
                      title: "تكسي",
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: _serviceCard(
                      icon: Icons.electric_rickshaw,
                      title: "تكتك",
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _serviceCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // سنربطه لاحقاً بشاشة اختيار موقع الانطلاق
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black12,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 70,
              color: color,
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}