import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class OmaAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  final List<Widget>? actions;

  final Widget? leading;

  final bool centerTitle;

  final bool showBackButton;

  final Color? backgroundColor;

  const OmaAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.showBackButton = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final dark =
        Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      automaticallyImplyLeading: false,

      centerTitle: centerTitle,

      elevation: 0,

      scrolledUnderElevation: 0,

      surfaceTintColor: Colors.transparent,

      backgroundColor:
          backgroundColor ??
          (dark
              ? AppColors.darkBackground
              : AppColors.lightBackground),

      leading: leading ??
          (showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null),

      title: Text(
        title,
        style: AppTextStyles.titleLarge,
      ),

      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}
