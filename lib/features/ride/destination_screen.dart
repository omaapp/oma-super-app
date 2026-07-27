import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الوجهة",
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
              "إلى أين تريد الذهاب؟",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              decoration: InputDecoration(
                hintText: "ابحث عن الوجهة...",
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "أماكن مقترحة",
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: const Icon(Icons.home),
                title: Text(
                  "المنزل",
                  style: GoogleFonts.cairo(),
                ),
                subtitle: const Text("إضافة لاحقاً"),
                onTap: () {},
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.work),
                title: Text(
                  "العمل",
                  style: GoogleFonts.cairo(),
                ),
                subtitle: const Text("إضافة لاحقاً"),
                onTap: () {},
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: Text(
                  "الأماكن المحفوظة",
                  style: GoogleFonts.cairo(),
                ),
                subtitle: const Text("قريباً"),
                onTap: () {},
              ),
            ),

            const Spacer(),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // سننتقل لاحقاً إلى شاشة البحث عن السائق
                },
                child: Text(
                  "تأكيد الوجهة",
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