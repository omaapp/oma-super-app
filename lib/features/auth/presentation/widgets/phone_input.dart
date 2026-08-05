import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneInput extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      style: GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        counterText: "",

        filled: true,
        fillColor: const Color(0xffF5F9FF),

        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Icon(
            Icons.phone_android,
            color: Color(0xff1565C0),
          ),
        ),

        prefixText: "+964 ",

        prefixStyle: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 17,
        ),

        hintText: "7xxxxxxxxx",

        hintStyle: GoogleFonts.cairo(
          color: Colors.grey.shade500,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xff1565C0),
            width: 2,
          ),
        ),
      ),
    );
  }
}