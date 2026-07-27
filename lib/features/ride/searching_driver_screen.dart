import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchingDriverScreen extends StatelessWidget {
  const SearchingDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "البحث عن سائق",
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const CircularProgressIndicator(
                strokeWidth: 5,
              ),

              const SizedBox(height: 35),

              Text(
                "جارٍ البحث عن أقرب سائق...",
                style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "يرجى الانتظار",
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}