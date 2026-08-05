import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: BorderSide(
          color: Colors.grey.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      icon: Image.network(
        "https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg",
        width: 24,
        height: 24,
      ),
      label: Text(
        "المتابعة بواسطة Google",
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class AppleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppleLoginButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: BorderSide(
          color: Colors.grey.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      icon: const Icon(
        Icons.apple,
        color: Colors.black,
      ),
      label: Text(
        "المتابعة بواسطة Apple",
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class GuestButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GuestButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.person_outline,
        color: Color(0xff1565C0),
      ),
      label: Text(
        "الدخول كضيف",
        style: GoogleFonts.cairo(
          color: const Color(0xff1565C0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}