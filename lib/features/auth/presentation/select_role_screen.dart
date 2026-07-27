import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff1565C0);

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Icon(
                Icons.account_circle,
                size: 90,
                color: primary,
              ),

              const SizedBox(height: 20),

              Text(
                "مرحباً بك",
                style: GoogleFonts.cairo(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "اختر نوع الحساب للمتابعة",
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 50),

              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    Navigator.pop(context, "customer");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 18,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 42,
                          backgroundColor: Color(0xffE3F2FD),
                          child: Icon(
                            Icons.person,
                            size: 45,
                            color: primary,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          "عميل",
                          style: GoogleFonts.cairo(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "اطلب سيارة أو تكتك بسهولة",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    Navigator.pop(context, "driver");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 18,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.local_taxi,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          "سائق",
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "استقبل طلبات الرحلات واربح المال",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}