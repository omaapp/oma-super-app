import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final String tripId;
  final String phone;
  final String pickup;
  final String destination;
  final String distance;
  final String duration;
  final String price;

  final VoidCallback onAccept;
  final VoidCallback onReject;

  const TripCard({
    super.key,
    required this.tripId,
    required this.phone,
    required this.pickup,
    required this.destination,
    required this.distance,
    required this.duration,
    required this.price,
    required this.onAccept,
    required this.onReject,
  });

  Widget row(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [

          Icon(
            icon,
            color: Colors.blue,
            size: 20,
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      elevation: 5,

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "طلب رحلة جديد",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const Divider(height: 25),

            row(
              Icons.phone,
              "العميل",
              phone,
            ),

            row(
              Icons.my_location,
              "الانطلاق",
              pickup,
            ),

            row(
              Icons.location_on,
              "الوجهة",
              destination,
            ),

            row(
              Icons.route,
              "المسافة",
              distance,
            ),

            row(
              Icons.access_time,
              "الوقت",
              duration,
            ),

            row(
              Icons.payments,
              "السعر",
              price,
            ),

            const SizedBox(height: 20),

            Row(

              children: [

                Expanded(

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),

                    onPressed: onAccept,

                    child: const Text(
                      "قبول",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                  ),

                ),

                const SizedBox(width: 10),

                Expanded(

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    onPressed: onReject,

                    child: const Text(
                      "رفض",
                      style: TextStyle(
                        color: Colors.white,
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
}