import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  final List<Widget>? actions;

  final Widget? leading;

  final bool centerTitle;

  final bool automaticallyImplyLeading;

  final Color? backgroundColor;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading:
          automaticallyImplyLeading,
      leading: leading,
      actions: actions,

      backgroundColor:
          backgroundColor ??
          (isDark
              ? AppColors.darkBackground
              : AppColors.lightBackground),

      surfaceTintColor: Colors.transparent,

      title: Text(
        title,
        style: AppTextStyles.heading,
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}