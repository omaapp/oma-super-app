import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "oma_logo",
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 25,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              "assets/branding/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 24),

        Text(
          "OMA",
          style: GoogleFonts.cairo(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "تنقّل بسهولة داخل العراق",
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            color: Colors.white70,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          style: GoogleFonts.cairo(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
