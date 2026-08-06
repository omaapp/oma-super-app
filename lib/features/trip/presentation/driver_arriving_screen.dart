import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/directions_service.dart';
import '../../trip/data/trip_service.dart';

class DriverArrivingScreen extends StatefulWidget {
  final String tripId;

  const DriverArrivingScreen({
    super.key,
    required this.tripId,
  });

  @override
  State<DriverArrivingScreen> createState() =>
      _DriverArrivingScreenState();
}

class _DriverArrivingScreenState
    extends State<DriverArrivingScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer();

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _tripSubscription;

  final Set<Marker> _markers = {};

  final Set<Polyline> _polylines = {};

  LatLng? customerLocation;
  LatLng? driverLocation;

  String customerAddress = "";
  String destinationAddress = "";

  String driverId = "";
  String driverName = "";
  String driverPhone = "";
  String driverPhoto = "";

  String vehicleName = "";
  String vehiclePlate = "";

  double driverRate = 5.0;

  String distance = "";
  String duration = "";

  bool loading = true;

  @override
  void initState() {
    super.initState();

    _listenTrip();
  }

  @override
  void dispose() {
    _tripSubscription?.cancel();
    super.dispose();
  }

  void _listenTrip() {
    _tripSubscription = TripService.instance
        .tripStream(widget.tripId)
        .listen(_onTripUpdated);
  }

  Future<void> _onTripUpdated(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) async {
    if (!snapshot.exists) return;

    final data = snapshot.data();

    if (data == null) return;

    customerLocation = LatLng(
      (data["pickupLat"] as num).toDouble(),
      (data["pickupLng"] as num).toDouble(),
    );

    customerAddress =
        data["pickupAddress"] ?? "";

    destinationAddress =
        data["destinationAddress"] ?? "";

    driverId =
        data["acceptedDriverId"] ?? "";

    if (data["driverLat"] != null &&
        data["driverLng"] != null) {
      driverLocation = LatLng(
        (data["driverLat"] as num).toDouble(),
        (data["driverLng"] as num).toDouble(),
      );
    }

    await _loadDriverInfo();

    await _drawDriverRoute();

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }
    Future<void> _loadDriverInfo() async {
    if (driverId.isEmpty) return;

    try {
      final driver = await FirebaseFirestore.instance
          .collection("drivers")
          .doc(driverId)
          .get();

      if (!driver.exists) return;

      final data = driver.data();

      if (data == null) return;

      driverName = data["name"] ?? "";

      driverPhone = data["phone"] ?? "";

      driverPhoto = data["photo"] ?? "";

      vehicleName = data["vehicleName"] ?? "";

      vehiclePlate = data["vehiclePlate"] ?? "";

      driverRate =
          (data["rating"] as num?)?.toDouble() ?? 5.0;
    } catch (_) {}
  }

  Future<void> _drawDriverRoute() async {
    if (driverLocation == null ||
        customerLocation == null) {
      return;
    }

    final route =
        await DirectionsService.instance.getDirections(
      origin: driverLocation!,
      destination: customerLocation!,
    );

    if (route == null) return;

    distance = route["distanceText"] ?? "";

    duration = route["durationText"] ?? "";

    final points =
        DirectionsService.instance.decodePolyline(
      route["polyline"],
    );

    _markers.clear();

    _markers.add(
      Marker(
        markerId: const MarkerId("driver"),
        position: driverLocation!,
        infoWindow: const InfoWindow(
          title: "السائق",
        ),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId("customer"),
        position: customerLocation!,
        infoWindow: const InfoWindow(
          title: "موقعك",
        ),
      ),
    );

    _polylines.clear();

    _polylines.add(
      Polyline(
        polylineId:
            const PolylineId("driver_route"),
        color: Colors.blue,
        width: 6,
        points: points,
      ),
    );

    if (_mapController.isCompleted) {
      final controller =
          await _mapController.future;

      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          _boundsFromLatLngList([
            driverLocation!,
            customerLocation!,
          ]),
          80,
        ),
      );
    }
  }

  LatLngBounds _boundsFromLatLngList(
    List<LatLng> list,
  ) {
    double? x0;
    double? x1;
    double? y0;
    double? y1;

    for (final latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) {
          x1 = latLng.latitude;
        }

        if (latLng.latitude < x0) {
          x0 = latLng.latitude;
        }

        if (latLng.longitude > y1!) {
          y1 = latLng.longitude;
        }

        if (latLng.longitude < y0!) {
          y0 = latLng.longitude;
        }
      }
    }

    return LatLngBounds(
      southwest: LatLng(x0!, y0!),
      northeast: LatLng(x1!, y1!),
    );
  }

  Future<void> _callDriver() async {
    if (driverPhone.isEmpty) return;

    final uri = Uri.parse(
      "tel:$driverPhone",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
    @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: customerLocation ??
                  const LatLng(33.3152, 44.3661),
              zoom: 15,
            ),

            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,

            markers: _markers,
            polylines: _polylines,

            onMapCreated: (controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
          ),

          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .12),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xff1565C0),
                    child: Icon(
                      Icons.directions_car,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "السائق في الطريق",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          duration.isEmpty
                              ? "جاري تحديد الوقت..."
                              : "يبعد عنك $duration",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: .12),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      distance.isEmpty
                          ? "--"
                          : distance,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
                    Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                22,
                20,
                22,
                28,
              ),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .15),
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
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 34,
                          backgroundImage:
                              driverPhoto.isNotEmpty
                                  ? NetworkImage(driverPhoto)
                                  : null,
                          child: driverPhoto.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 34,
                                )
                              : null,
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                driverName.isEmpty
                                    ? "السائق"
                                    : driverName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    driverRate
                                        .toStringAsFixed(1),
                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: .1),
                            borderRadius:
                                BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              Text(
                                vehicleName.isEmpty
                                    ? "-"
                                    : vehicleName,
                                style: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                vehiclePlate.isEmpty
                                    ? "-"
                                    : vehiclePlate,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue
                                  .withValues(alpha: .08),
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  color: Colors.blue,
                                ),

                                const SizedBox(height: 8),

                                const Text(
                                  "الوقت",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  duration,
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green
                                  .withValues(alpha: .08),
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.route,
                                  color: Colors.green,
                                ),

                                const SizedBox(height: 8),

                                const Text(
                                  "المسافة",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  distance,
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                                        Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _callDriver,
                            icon: const Icon(Icons.phone),
                            label: const Text("اتصال"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.green,
                              foregroundColor:
                                  Colors.white,
                              minimumSize:
                                  const Size(0, 56),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        18),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "سيتم إضافة المحادثة قريباً",
                                  ),
                                ),
                              );
                            },
                            icon:
                                const Icon(Icons.chat),
                            label:
                                const Text("محادثة"),
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  const Size(0, 56),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                color: Colors.green,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "نقطة الانطلاق",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Text(
                            customerAddress.isEmpty
                                ? "موقعي الحالي"
                                : customerAddress,
                          ),

                          const Divider(height: 28),

                          const Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "الوجهة",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Text(destinationAddress),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}