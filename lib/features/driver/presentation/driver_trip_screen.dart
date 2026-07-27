import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/services/live_trip_location_service.dart';
import '../controllers/driver_trip_map_controller.dart';
import '../data/driver_service.dart';

class DriverTripScreen extends StatefulWidget {
  final String tripId;

  final String phone;

  final String pickup;

  final String destination;

  final String distance;

  final String duration;

  final String price;

  final double customerLat;

  final double customerLng;

  const DriverTripScreen({
    super.key,
    required this.tripId,
    required this.phone,
    required this.pickup,
    required this.destination,
    required this.distance,
    required this.duration,
    required this.price,
    required this.customerLat,
    required this.customerLng,
  });

  @override
  State<DriverTripScreen> createState() =>
      _DriverTripScreenState();
}

class _DriverTripScreenState
    extends State<DriverTripScreen> {

  final user = FirebaseAuth.instance.currentUser;

  late DriverTripMapController map;

  @override
  void initState() {
    super.initState();

    map = DriverTripMapController(
      customerLat: widget.customerLat,
      customerLng: widget.customerLng,
    );

    map.start(() {
  if (!mounted) return;

  setState(() {});
});
    _startLiveLocation();
  }

  Future<void> _startLiveLocation() async {
    if (user == null) return;

    await LiveTripLocationService.instance.start(
      driverId: user!.uid,
      tripId: widget.tripId,
    );
  }

  @override
  void dispose() {
    map.dispose();
    LiveTripLocationService.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("الرحلة الحالية"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          SizedBox(
            height: 260,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(18),
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(
                  target: LatLng(
                    widget.customerLat,
                    widget.customerLng,
                  ),
                  zoom: 15,
                ),

                myLocationEnabled: true,

                myLocationButtonEnabled: false,

                markers: map.markers,

                polylines: map.polylines,

                onMapCreated: (controller) {
                  if (!map
                      .mapController
                      .isCompleted) {
                    map.mapController
                        .complete(controller);
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 20),
                    Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text("رقم العميل"),
              subtitle: Text(widget.phone),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            child: ListTile(
              leading: const Icon(Icons.my_location),
              title: const Text("مكان الالتقاط"),
              subtitle: Text(widget.pickup),
            ),
          ),

          const SizedBox(height: 15),

          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("الوجهة"),
              subtitle: Text(widget.destination),
            ),
          ),

          const SizedBox(height: 15),

          Card(
  child: ListTile(
    leading: const Icon(Icons.route),
    title: const Text("المسافة المتبقية"),
    trailing: Text(
      map.distance,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

          const SizedBox(height: 15),

          Card(
  child: ListTile(
    leading: const Icon(Icons.access_time),
    title: const Text("وقت الوصول"),
    trailing: Text(
      map.duration,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

          const SizedBox(height: 15),

          Card(
            child: ListTile(
              leading: const Icon(Icons.payments),
              title: const Text("الأجرة"),
              trailing: Text(widget.price),
            ),
          ),

          const SizedBox(height: 35),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.navigation),
              label: const Text(
                "وصلت إلى العميل",
              ),
              onPressed: () async {

                await DriverService.instance
                    .arrivedToPickup(
                  widget.tripId,
                );

                if (!mounted) return;

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "تم إشعار العميل بوصولك",
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text(
                "بدء الرحلة",
              ),
              onPressed: () async {

                await DriverService.instance
                    .startTrip(
                  widget.tripId,
                );

                if (!mounted) return;

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "بدأت الرحلة",
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),
                    SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              icon: const Icon(Icons.check),
              label: const Text(
                "إنهاء الرحلة",
              ),
              onPressed: () async {

                if (user != null) {

                  await DriverService.instance
                      .finishTrip(
                    tripId: widget.tripId,
                    driverId: user!.uid,
                  );

                  await LiveTripLocationService
                      .instance
                      .stop();

                  if (!mounted) return;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "تم إنهاء الرحلة",
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              icon: const Icon(Icons.close),
              label: const Text(
                "إلغاء الرحلة",
              ),
              onPressed: () async {

                if (user != null) {

                  await DriverService.instance
                      .cancelTrip(
                    tripId: widget.tripId,
                    driverId: user!.uid,
                  );

                  await LiveTripLocationService
                      .instance
                      .stop();

                  if (!mounted) return;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "تم إلغاء الرحلة",
                      ),
                    ),
                  );
                }
              },
            ),
          ),
                  ],
      ),
    );
  }
}