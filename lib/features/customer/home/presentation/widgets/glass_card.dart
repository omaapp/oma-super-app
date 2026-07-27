import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = 24,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool dark =
        theme.brightness == Brightness.dark;

    final card = ClipRRect(
      borderRadius:
          BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(borderRadius),

            color: dark
                ? const Color(0xff1E1E1E)
                    .withOpacity(.78)
                : Colors.white.withOpacity(.65),

            border: Border.all(
              color: dark
                  ? Colors.white10
                  : Colors.white.withOpacity(.55),
              width: 1.2,
            ),

            boxShadow: [
              BoxShadow(
                color: dark
                    ? Colors.black54
                    : Colors.black.withOpacity(.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    if (onTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: card,
      ),
    );
  }
}