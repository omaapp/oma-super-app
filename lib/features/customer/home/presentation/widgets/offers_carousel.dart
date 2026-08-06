import 'dart:async';

import 'package:flutter/material.dart';

import '../../../map/presentation/map_screen.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

import '../../../../../core/widgets/oma_card.dart';
import '../../../../../core/widgets/primary_button.dart';

class OffersCarousel extends StatefulWidget {
  const OffersCarousel({super.key});

  @override
  State<OffersCarousel> createState() =>
      _OffersCarouselState();
}

class _OffersCarouselState
    extends State<OffersCarousel> {
  late final PageController controller;

  int currentPage = 0;

  Timer? timer;

  final List<_OfferItem> offers = const [
    _OfferItem(
      title: "خصم 30%",
      subtitle: "على أول رحلة لك",
      color: AppColors.primary,
      icon: Icons.local_offer_rounded,
    ),
    _OfferItem(
      title: "Taxi",
      subtitle: "رحلات أسرع داخل المدينة",
      color: Colors.orange,
      icon: Icons.local_taxi_rounded,
    ),
    _OfferItem(
      title: "Tuk Tuk",
      subtitle: "تنقل سريع واقتصادي",
      color: AppColors.success,
      icon: Icons.electric_rickshaw_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();

    controller = PageController(
      viewportFraction: .90,
    );

    timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        currentPage++;

        if (currentPage >= offers.length) {
          currentPage = 0;
        }

        controller.animateToPage(
          currentPage,
          duration: const Duration(
            milliseconds: 450,
          ),
          curve: Curves.easeInOut,
        );

        if (mounted) {
          setState(() {});
        }
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
          height: 220,

          child: PageView.builder(
            controller: controller,

            itemCount: offers.length,

            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },

            itemBuilder: (_, index) {

              final item = offers[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
                ),

                child: OmaCard(
                  onTap: () => _openOffer(
                    context,
                    item,
                  ),

                  padding: EdgeInsets.zero,

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                        AppRadius.large,
                      ),

                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,

                        colors: [
                          item.color,
                          item.color.withValues(
                            alpha: .85,
                          ),
                        ],
                      ),
                    ),

                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                        AppSpacing.xl,
                      ),

                      child: Row(
                        children: [

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                              children: [

                                Text(
                                  item.title,

                                  style:
                                      AppTextStyles
                                          .titleMedium
                                          .copyWith(
                                    color:
                                        Colors.white,
                                  ),
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                Text(
                                  item.subtitle,

                                  style:
                                      AppTextStyles
                                          .bodyMedium
                                          .copyWith(
                                    color:
                                        Colors.white,
                                  ),
                                ),

                                const SizedBox(
                                  height: 24,
                                ),

                                SizedBox(
                                  width: 150,

                                  child:
                                      PrimaryButton(
                                    text:
                                        "اطلب الآن",

                                    icon: Icons
                                        .arrow_forward,

                                    backgroundColor:
                                        Colors.white,

                                    foregroundColor:
                                        item.color,

                                    onPressed: () {
                                      _openOffer(
                                        context,
                                        item,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            width: 18,
                          ),

                          Container(
                            width: 90,
                            height: 90,

                            decoration:
                                BoxDecoration(
                              color: Colors.white
                                  .withValues(
                                alpha: .15,
                              ),

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                24,
                              ),
                            ),

                            child: Icon(
                              item.icon,

                              color:
                                  Colors.white,

                              size: 46,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
                const SizedBox(height: 18),

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: List.generate(
            offers.length,
            (index) {
              final active =
                  currentPage == index;

              return AnimatedContainer(
                duration: const Duration(
                  milliseconds: 250,
                ),

                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 4,
                ),

                height: 8,

                width: active ? 26 : 8,

                decoration: BoxDecoration(
                  color: active
                      ? AppColors.primary
                      : Colors.grey.withValues(
                          alpha: .35,
                        ),

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

  void _openOffer(
    BuildContext context,
    _OfferItem item,
  ) {
    if (item.title == "خصم 30%") {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "سيتم عرض جميع العروض قريباً",
          ),
        ),
      );

      return;
    }

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
