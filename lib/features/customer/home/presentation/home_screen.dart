import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/page_padding.dart';

import 'widgets/animated_appear.dart';
import 'widgets/animated_background.dart';
import 'widgets/hero_banner.dart';
import 'widgets/home_header.dart';
import 'widgets/news_section.dart';
import 'widgets/offers_carousel.dart';
import 'widgets/quick_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: PagePadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  SizedBox(height: 8),

                  AnimatedAppear(
                    delay: Duration(milliseconds: 100),
                    child: HomeHeader(),
                  ),

                  SizedBox(height: 20),

                  AnimatedAppear(
                    delay: Duration(milliseconds: 250),
                    child: HeroBanner(),
                  ),

                  SizedBox(height: 28),

                  AnimatedAppear(
                    delay: Duration(milliseconds: 420),
                    child: OffersCarousel(),
                  ),

                  SizedBox(height: 30),

                  AnimatedAppear(
                    delay: Duration(milliseconds: 550),
                    child: QuickServices(),
                  ),

                  SizedBox(height: 30),

                  NewsSection(),

                  SizedBox(height: 30),

                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
