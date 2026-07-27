import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'controllers/customer_trip_map_controller.dart';

class CustomerTripScreen extends StatefulWidget {
  final String tripId;

  const CustomerTripScreen({
    super.key,
    required this.tripId,
  });

  @override
  State<CustomerTripScreen> createState() =>
      _CustomerTripScreenState();
}

class _CustomerTripScreenState
    extends State<CustomerTripScreen> {

  late CustomerTripMapController map;

  @override
  void initState() {
    super.initState();

    map = CustomerTripMapController(
      tripId: widget.tripId,
    );

    map.start(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    map.dispose();
    super.dispose();
  }

  String get statusText {
    switch (map.status) {

      case "pending":
        return "جاري البحث عن سائق";

      case "accepted":
        return "تم قبول الرحلة";

      case "arrived":
        return "السائق وصل";

      case "on_trip":
        return "الرحلة بدأت";

      case "completed":
        return "تم إنهاء الرحلة";

      case "cancelled":
        return "تم إلغاء الرحلة";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("متابعة الرحلة"),
        centerTitle: true,
      ),

      body: Column(

        children: [

          Expanded(

            child: GoogleMap(

              initialCameraPosition:
                  const CameraPosition(
                target: LatLng(
                  33.3152,
                  44.3661,
                ),
                zoom: 15,
              ),

              myLocationEnabled: true,

              myLocationButtonEnabled: false,

              zoomControlsEnabled: false,

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

          Container(

            width: double.infinity,

            padding:
                const EdgeInsets.all(20),

            decoration:
                const BoxDecoration(

              color: Colors.white,

              boxShadow: [

                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                ),
              ],
            ),

            child: Column(

              children: [

                Text(

                  statusText,

                  style:
                      const TextStyle(

                    fontSize: 22,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "المسافة المتبقية",
                    ),

                    Text(
                      map.distance.isEmpty
                          ? "--"
                          : map.distance,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "الوقت المتوقع",
                    ),

                    Text(
                      map.duration.isEmpty
                          ? "--"
                          : map.duration,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}