import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupLocationScreen extends StatelessWidget {
  const PickupLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "موقع الانطلاق",
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 20),

            Text(
              "من أين ستبدأ الرحلة؟",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              decoration: InputDecoration(
                hintText: "ابحث عن مكان...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.my_location,
                  color: Color(0xFF1565C0),
                ),
                title: Text(
                  "استخدام موقعي الحالي",
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "سيتم تحديد موقعك تلقائياً",
                  style: GoogleFonts.cairo(),
                ),
                onTap: () {
                  // سنربطه بخدمة تحديد الموقع لاحقاً
                },
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.map,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // سننتقل لاحقاً إلى شاشة الوجهة
                },
                child: Text(
                  "التالي",
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}