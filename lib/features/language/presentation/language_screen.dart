import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/presentation/login_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'ar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              const Icon(
                Icons.language,
                size: 90,
                color: Color(0xFF1565C0),
              ),

              const SizedBox(height: 20),

              Text(
                "Oma",
                style: GoogleFonts.cairo(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "اختر لغة التطبيق",
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 40),

              _languageCard(
                title: "العربية",
                flag: "🇮🇶",
                value: "ar",
              ),

              const SizedBox(height: 15),

              _languageCard(
                title: "English",
                flag: "🇺🇸",
                value: "en",
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "متابعة",
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageCard({
    required String title,
    required String flag,
    required String value,
  }) {
    final selected = _selectedLanguage == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedLanguage = value;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF1565C0).withValues(alpha: 0.1)
              : Colors.white,
          border: Border.all(
            color: selected
                ? const Color(0xFF1565C0)
                : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF1565C0),
              ),
          ],
        ),
      ),
    );
  }
}