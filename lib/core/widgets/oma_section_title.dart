import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class OmaSectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const OmaSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.padding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.heading,
                ),

                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: AppTextStyles.caption,
                  ),
                ],
              ],
            ),
          ),

          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class OmaDivider extends StatelessWidget {
  final double height;

  const OmaDivider({
    super.key,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: height,
      color: Theme.of(context).brightness ==
              Brightness.dark
          ? Colors.white12
          : AppColors.divider,
    );
  }
}