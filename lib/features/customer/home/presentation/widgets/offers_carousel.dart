import 'dart:async';

import 'package:flutter/material.dart';
import '../../../map/presentation/map_screen.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({super.key});

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {
  final PageController controller =
      PageController(viewportFraction: .92);

  int currentPage = 0;

  Timer? timer;

  final List<_OfferItem> offers = const [
    _OfferItem(
      title: "خصم 30%",
      subtitle: "على أول رحلة لك",
      color: Color(0xff1565C0),
      icon: Icons.local_offer,
    ),
    _OfferItem(
      title: "Taxi",
      subtitle: "رحلات أسرع داخل المدينة",
      color: Colors.orange,
      icon: Icons.local_taxi,
    ),
    _OfferItem(
      title: "Tuk Tuk",
      subtitle: "تنقل سريع واقتصادي",
      color: Colors.green,
      icon: Icons.electric_rickshaw,
    ),
  ];

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        currentPage++;

        if (currentPage >= offers.length) {
          currentPage = 0;
        }

        controller.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: controller,
            itemCount: offers.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (_, index) {
              final item = offers[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MapScreen(
                        initialVehicle:
                            item.title == "Tuk Tuk"
                                ? "tuk"
                                : "taxi",
                      ),
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppRadius.large,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        item.color,
                        item.color.withOpacity(.75),
                      ],
                    ),
                    boxShadow: AppShadows.card,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppSpacing.lg,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style:
                                    AppTextStyles.title.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item.subtitle,
                                style:
                                    AppTextStyles.body.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.white24,
                          child: Icon(
                            item.icon,
                            color: Colors.white,
                            size: 42,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            offers.length,
            (index) {
              final active = currentPage == index;

              return AnimatedContainer(
                duration:
                    const Duration(milliseconds: 250),
                margin:
                    const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xff1565C0)
                      : Colors.grey.shade400,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OfferItem {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _OfferItem({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });
}