import 'package:flutter/material.dart';

import '../../../../notifications/presentation/widgets/notification_badge.dart';
import '../../../../settings/presentation/home_settings_sheet.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "صباح الخير";
    } else if (hour < 17) {
      return "مساء الخير";
    } else {
      return "مساء الخير";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: theme.colorScheme.primary,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_greeting()} 👋",
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface
                            .withOpacity(.65),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "محمد",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:
                            theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              const NotificationBadge(),

              const SizedBox(width: 8),

              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.settings_rounded,
                    color:
                        theme.colorScheme.onSurface,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor:
                          theme.cardColor,
                      shape:
                          const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (_) =>
                          const HomeSettingsSheet(),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius:
                  BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  color: theme.brightness ==
                          Brightness.dark
                      ? Colors.black26
                      : Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary
                        .withOpacity(.12),
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "موقعك الحالي",
                        style: TextStyle(
                          fontSize: 13,
                          color: theme
                              .colorScheme.onSurface
                              .withOpacity(.6),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "الرفاعي • ذي قار",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 17,
                          color: theme
                              .colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "تغيير",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}