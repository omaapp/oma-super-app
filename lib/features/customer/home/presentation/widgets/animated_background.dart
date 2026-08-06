import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackground> createState() =>
      _AnimatedBackgroundState();
}

class _AnimatedBackgroundState
    extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        return CustomPaint(
          painter: _BackgroundPainter(
            controller.value,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double progress;

  _BackgroundPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color(0xff1565C0).withValues(alpha: .05);

    for (int i = 0; i < 18; i++) {
      final x = (size.width / 18) * i;

      final y =
          size.height *
              (.5 +
                  .4 *
                      sin(
                        progress * 2 * pi + i,
                      ));

      canvas.drawCircle(
        Offset(x, y),
        20,
        paint,
      );
    }

    final paint2 = Paint()
      ..color =
          Colors.blue.withValues(alpha: .03);

    for (int i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset(
          size.width *
              (.1 + i * .08),
          size.height *
              (.15 +
                  .6 *
                      cos(
                        progress * 2 * pi + i,
                      )),
        ),
        35,
        paint2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}