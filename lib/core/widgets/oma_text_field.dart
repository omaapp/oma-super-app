import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class OmaTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hint;

  final String? label;

  final IconData? prefixIcon;

  final Widget? suffixIcon;

  final TextInputType keyboardType;

  final bool obscureText;

  final int? maxLength;

  final ValueChanged<String>? onChanged;

  final String? Function(String?)? validator;

  const OmaTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboardType,

      obscureText: obscureText,

      maxLength: maxLength,

      onChanged: onChanged,

      validator: validator,

      style: AppTextStyles.body,

      decoration: InputDecoration(
        counterText: "",

        hintText: hint,

        labelText: label,

        hintStyle: AppTextStyles.caption,

        labelStyle: AppTextStyles.caption,

        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: AppColors.primary,
              ),

        suffixIcon: suffixIcon,

        filled: true,

        fillColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkSurface
                : Colors.white,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.divider,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
      ),
    );
  }
}