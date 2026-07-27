import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/trip_service.dart';
import 'trip_completed_screen.dart';

class OnTripScreen extends StatefulWidget {
  final String tripId;

  const OnTripScreen({
    super.key,
    required this.tripId,
  });

  @override
  State<OnTripScreen> createState() =>
      _OnTripScreenState();
}

class _OnTripScreenState
    extends State<OnTripScreen> {

  StreamSubscription? subscription;

  String status = "";

  String driverName = "";

  String vehicle = "";

  String distance = "";

  String duration = "";

  LatLng? driverLocation;

  @override
  void initState() {
    super.initState();
    listenTrip();
  }

  void listenTrip() {
    subscription = TripService.instance
        .tripStream(widget.tripId)
        .listen((trip) {
      if (!trip.exists) return;

      final data = trip.data();

      if (data == null) return;

      status = data["status"] ?? "";

      driverName = data["driverName"] ?? "السائق";

      vehicle = data["vehicleType"] ?? "";

      distance = data["distance"]?.toString() ?? "";

      duration = data["duration"]?.toString() ?? "";

      final lat =
          (data["driverLat"] as num?)?.toDouble();

      final lng =
          (data["driverLng"] as num?)?.toDouble();

      if (lat != null && lng != null) {
        driverLocation = LatLng(lat, lng);
      }

      if (!mounted) return;

      setState(() {});

      if (status == "completed") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TripCompletedScreen(
              tripId: widget.tripId,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرحلة جارية"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.local_taxi,
                    size: 60,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    driverName.isEmpty
                        ? "السائق"
                        : driverName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    vehicle == "taxi"
                        ? "تكسي"
                        : "تكتك",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16),

                      child: Column(
                        children: [

                          const Icon(
                            Icons.route,
                            color: Colors.blue,
                          ),

                          const SizedBox(height: 10),

                          const Text("المسافة"),

                          const SizedBox(height: 8),

                          Text(
                            distance,
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(16),

                      child: Column(
                        children: [

                          const Icon(
                            Icons.timer,
                            color: Colors.orange,
                          ),

                          const SizedBox(height: 10),

                          const Text("الوقت"),

                          const SizedBox(height: 8),

                          Text(
                            duration,
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "حالة الرحلة",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.directions_car,
                    color: Colors.green,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "السائق في الطريق إلى الوجهة",
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              height: 55,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.call),

                label: const Text(
                  "الاتصال بالسائق",
                ),

                onPressed: () {
                  // سيتم ربطه لاحقاً
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}