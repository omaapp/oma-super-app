import 'package:flutter/material.dart';

class VehicleOptionCard extends StatelessWidget {
  final IconData icon;

  final String title;

  final String eta;

  final String price;

  final VoidCallback onTap;

  const VehicleOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.eta,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20),

          color: Colors.grey.shade100,
        ),

        child: Row(
          children: [

            Icon(
              icon,
              size: 34,
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  Text(eta),
                ],
              ),
            ),

            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}