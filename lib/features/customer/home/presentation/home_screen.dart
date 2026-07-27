import 'package:flutter/material.dart';

import 'widgets/home_header.dart';
import 'widgets/hero_banner.dart';
import 'widgets/offers_carousel.dart';
import 'widgets/quick_services.dart';
import 'widgets/coming_soon_section.dart';
import 'widgets/promo_card.dart';
import 'widgets/footer.dart';
import 'widgets/animated_background.dart';
import 'widgets/animated_appear.dart';
import 'widgets/why_oma_section.dart';
import 'widgets/news_section.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: AnimatedBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),

            child: Column(
  children: [

    const AnimatedAppear(
      delay: Duration(milliseconds: 100),
      child: HomeHeader(),
    ),

    const SizedBox(height: 18),

    const AnimatedAppear(
      delay: Duration(milliseconds: 250),
      child: HeroBanner(),
    ),

    const SizedBox(height: 20),

    const AnimatedAppear(
      delay: Duration(milliseconds: 400),
      child: OffersCarousel(),
    ),

    const SizedBox(height: 25),

    const AnimatedAppear(
      delay: Duration(milliseconds: 550),
      child: QuickServices(),
    ),

    const SizedBox(height: 25),

    const AnimatedAppear(
      delay: Duration(milliseconds: 700),
      child: PromoCard(),
    ),

    const SizedBox(height: 25),

WhyOmaSection(),
const SizedBox(height: 25),

NewsSection(),
    const AnimatedAppear(
      delay: Duration(milliseconds: 850),
      child: ComingSoonSection(),
    ),

    const SizedBox(height: 30),

    const AnimatedAppear(
      delay: Duration(milliseconds: 1000),
      child: Footer(),
    ),
  ],
),
          ),
        ),
      ),
    );
  }
}