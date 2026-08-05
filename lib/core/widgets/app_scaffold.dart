import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_app_bar.dart';
class AppScaffold extends StatelessWidget {
  final Widget body;

  final String? title;

  final Widget? floatingActionButton;

  final Widget? bottomNavigationBar;

  final PreferredSizeWidget? appBar;

  final bool safeArea;

  final bool resizeToAvoidBottomInset;

  final Color? backgroundColor;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.safeArea = true,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,

      backgroundColor:
          backgroundColor ??
          (isDark
              ? AppColors.darkBackground
              : AppColors.lightBackground),

      appBar: appBar ??
    (title == null
        ? null
        : AppAppBar(
            title: title!,
          )),

      body: safeArea
          ? SafeArea(child: body)
          : body,

      floatingActionButton: floatingActionButton,

      bottomNavigationBar: bottomNavigationBar,
    );
  }
}