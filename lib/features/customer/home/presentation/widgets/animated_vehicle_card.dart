import 'package:flutter/material.dart';

import 'glass_card.dart';

class AnimatedVehicleCard extends StatefulWidget {
  const AnimatedVehicleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.badge,
    required this.eta,
    required this.rating,
    required this.price,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String badge;
  final String eta;
  final String rating;
  final String price;
  final VoidCallback? onTap;

  @override
  State<AnimatedVehicleCard> createState() =>
      _AnimatedVehicleCardState();
}

class _AnimatedVehicleCardState
    extends State<AnimatedVehicleCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedScale(
      duration: const Duration(milliseconds: 180),
      scale: pressed ? .97 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(
                alpha: pressed ? .18 : .28,
              ),
              blurRadius: pressed ? 10 : 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              pressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              pressed = false;
            });

            widget.onTap?.call();
          },
          onTapCancel: () {
            setState(() {
              pressed = false;
            });
          },
          child: GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: .12),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.badge,
                          style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),

                      const Spacer(),

                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 18,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        widget.rating,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Hero(
                    tag: widget.title,
                    child: Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: .12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        size: 46,
                        color: widget.color,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color:
                          theme.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withValues(alpha: .65),
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.access_time_filled,
                        size: 18,
                        color: widget.color,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        widget.eta,
                        style: TextStyle(
                          color: widget.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          widget.color.withValues(alpha: .10),
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    child: Text(
                      widget.price,
                      style: TextStyle(
                        color: widget.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: widget.color,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: widget.onTap,
                      child: const Text(
                        "احجز الآن",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}