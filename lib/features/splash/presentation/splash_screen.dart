import 'dart:async';

import 'package:flutter/material.dart';

import '../../customer/home/presentation/home_screen.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scale;

  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );

    scale = Tween(
      begin: .7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    controller.forward();

    Timer(
      const Duration(seconds: 2),
      () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const OnboardingScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xff1565C0),

      body: Center(
        child: FadeTransition(
          opacity: opacity,

          child: ScaleTransition(
            scale: scale,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  height: 120,

                  decoration:
                      const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xff1565C0),
                    size: 70,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Oma",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight:
                        FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "رحلتك تبدأ هنا",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}