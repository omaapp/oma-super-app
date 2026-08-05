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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        22,
        14,
        22,
        22,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(34),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            blurRadius: 30,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(30),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xff1565C0),
                  child: Icon(
                    Icons.local_taxi,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "رحلتك",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff1565C0)
                        .withOpacity(.10),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    vehicleType.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xff1565C0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            VehicleSelector(
              selectedVehicle: vehicleType,
              onChanged: onVehicleChanged,
            ),

            const SizedBox(height: 24),
            if (!hasDestination) ...[
  Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.orange.withOpacity(.08),
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Row(
      children: [
        Icon(
          Icons.location_searching,
          color: Colors.orange,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            "اختر وجهتك من البحث أو اضغط على الخريطة",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  ),
] else ...[
  Row(
    children: [
      Expanded(
        child: _StatCard(
          icon: Icons.route,
          title: "المسافة",
          value: distance,
          color: Colors.blue,
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: _StatCard(
          icon: Icons.schedule,
          title: "الوقت",
          value: duration,
          color: Colors.orange,
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: _StatCard(
          icon: Icons.payments,
          title: "السعر",
          value: price,
          color: Colors.green,
        ),
      ),
    ],
  ),

  const SizedBox(height: 24),
  if (tripStatus == "accepted" ||
    tripStatus == "arrived" ||
    tripStatus == "started") ...[
  Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(.06),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: Colors.green.withOpacity(.15),
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xff1565C0),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driverName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    driverCar,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "4.9",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                // سيتم ربط الاتصال بالسائق لاحقاً
              },
              icon: const Icon(
                Icons.phone,
                color: Colors.green,
              ),
            ),
          ],
        ),

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
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  ),

  const SizedBox(height: 24),
],
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(.12),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(.12),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(.65),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
