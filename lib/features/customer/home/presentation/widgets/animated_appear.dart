import 'package:flutter/material.dart';

class AnimatedAppear extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const AnimatedAppear({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedAppear> createState() =>
      _AnimatedAppearState();
}

class _AnimatedAppearState
    extends State<AnimatedAppear>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> opacity;

  late Animation<Offset> slide;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );

    opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    slide = Tween<Offset>(
      begin: const Offset(0, .15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: opacity,

      child: SlideTransition(
        position: slide,
        child: widget.child,
      ),
    );
  }
}