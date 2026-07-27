import 'package:flutter/material.dart';

class IncomingTripDialog extends StatelessWidget {
  final Map<String, dynamic> trip;

  final VoidCallback onAccept;
  final VoidCallback onReject;

  const IncomingTripDialog({
    super.key,
    required this.trip,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final price =
        (trip["price"] ?? 0).toString();

    final distance =
        (trip["distance"] ?? 0).toString();

    final duration =
        (trip["duration"] ?? 0).toString();

    final pickup =
        trip["pickupAddress"] ?? "";

    final destination =
        trip["destinationAddress"] ?? "";

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Icon(
              Icons.notifications_active,
              color: Colors.green,
              size: 70,
            ),

            const SizedBox(height: 15),

            const Text(
              "طلب رحلة جديد",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            _infoRow(
              Icons.my_location,
              "الانطلاق",
              pickup,
            ),

            const SizedBox(height: 12),

            _infoRow(
              Icons.location_on,
              "الوجهة",
              destination,
            ),

            const SizedBox(height: 12),

            _infoRow(
              Icons.route,
              "المسافة",
              "$distance متر",
            ),

            const SizedBox(height: 12),

            _infoRow(
              Icons.access_time,
              "المدة",
              "$duration ثانية",
            ),

            const SizedBox(height: 12),

            _infoRow(
              Icons.payments,
              "السعر",
              "$price د.ع",
            ),

            const SizedBox(height: 28),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green,
                      minimumSize:
                          const Size(
                        0,
                        50,
                      ),
                    ),
                    child: const Text(
                      "قبول",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: onReject,
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red,
                      minimumSize:
                          const Size(
                        0,
                        50,
                      ),
                    ),
                    child: const Text(
                      "رفض",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: Colors.blue,
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const Spacer(),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}