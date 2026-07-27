import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class OmaLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const OmaLoader({
    super.key,
    this.size = 34,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation(
          color ?? AppColors.primary,
        ),
      ),
    );
  }
}