import 'package:flutter/material.dart';

import 'request_trip_button.dart';
import 'vehicle_selector.dart';

class TripInfoCard extends StatelessWidget {
  final bool hasDestination;

  final String vehicleType;
  final ValueChanged<String> onVehicleChanged;

  final String distance;
  final String duration;
  final String price;

  final VoidCallback onRequestTrip;

  final String tripStatus;

  final String driverName;
  final String driverCar;
  final String driverPhone;

  const TripInfoCard({
    super.key,
    required this.hasDestination,
    required this.vehicleType,
    required this.onVehicleChanged,
    required this.distance,
    required this.duration,
    required this.price,
    required this.onRequestTrip,

    required this.tripStatus,
    required this.driverName,
    required this.driverCar,
    required this.driverPhone,
  });

  Widget _infoCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(.08),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.fromLTRB(
        22,
        12,
        22,
        22,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(
                  Icons.route,
                  color: Color(0xff1565C0),
                ),
                const SizedBox(width: 8),
                Text(
                  "رحلتك",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            VehicleSelector(
              selectedVehicle: vehicleType,
              onChanged: onVehicleChanged,
            ),

            const SizedBox(height: 22),
if (tripStatus == "accepted" ||
    tripStatus == "arrived" ||
    tripStatus == "started") ...[

  Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(.08),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.green,
            ),
            SizedBox(width: 8),
            Text(
              "بيانات السائق",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Text(
          "الاسم : $driverName",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text("المركبة : $driverCar"),

        const SizedBox(height: 6),

        Text("الهاتف : $driverPhone"),

        const SizedBox(height: 18),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              tripStatus == "accepted"
                  ? "السائق في الطريق إليك"
                  : tripStatus == "arrived"
                      ? "السائق وصل"
                      : "الرحلة جارية",

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    ),
  ),

  const SizedBox(height: 20),
],
            if (!hasDestination)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.location_searching,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "اختر وجهتك من البحث أو اضغط على الخريطة",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else ...[
              Row(
                children: [
                  _infoCard(
                    Icons.route,
                    "المسافة",
                    distance,
                    Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _infoCard(
                    Icons.schedule,
                    "الوقت",
                    duration,
                    Colors.orange,
                  ),
                  const SizedBox(width: 12),
                  _infoCard(
                    Icons.payments,
                    "السعر",
                    price,
                    Colors.green,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: RequestTripButton(
                  onPressed: onRequestTrip,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}