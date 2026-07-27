import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الرحلة الحالية",
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Expanded(
              flex: 2,
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

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(
                  "اسم السائق",
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "تكسي - Toyota",
                  style: GoogleFonts.cairo(),
                ),
                trailing: const Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.cancel),
                label: Text(
                  "إلغاء الرحلة",
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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