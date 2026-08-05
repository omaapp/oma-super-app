import 'package:flutter/material.dart';

import '../theme/app_animation.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

class OmaCard extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  final VoidCallback? onTap;

  final Color? color;

  final double radius;

  final bool bordered;

  /// يسمح بتخصيص الظل عند الحاجة
  final List<BoxShadow>? boxShadow;

  /// يسمح بتخصيص لون الحدود
  final Color? borderColor;

  const OmaCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.color,
    this.radius = AppRadius.xl,
    this.bordered = false,
    this.boxShadow,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark =
        Theme.of(context).brightness == Brightness.dark;

    final decoration = BoxDecoration(
      color: color ??
          (dark
              ? AppColors.darkCard
              : AppColors.surface),
      borderRadius: BorderRadius.circular(radius),

      border: bordered
          ? Border.all(
              color: borderColor ??
                  (dark
                      ? Colors.white12
                      : Colors.black12),
            )
          : null,

      // لا نستخدم Shadow في الوضع الليلي
      boxShadow: dark
          ? null
          : (boxShadow ?? AppShadows.card),
    );

    final card = AnimatedContainer(
      duration: AppAnimation.normal,
      curve: Curves.easeInOut,
      margin: margin,
      padding: padding,
      decoration: decoration,
      child: child,
    );

    if (onTap == null) {
      return card;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: card,
        ),
      ),
    );
  }
}