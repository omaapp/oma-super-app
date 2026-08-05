import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/services/directions_service.dart';

class CustomerTripMapController {
  CustomerTripMapController({
    required this.tripId,
  });

  final String tripId;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  final Set<Marker> markers = {};

  final Set<Polyline> polylines = {};

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _subscription;

  String distance = "";

  String duration = "";

  String status = "pending";

  bool firstMove = true;

  Future<void> start(
    VoidCallback refresh,
  ) async {

    _subscription = FirebaseFirestore.instance
        .collection("trips")
        .doc(tripId)
        .snapshots()
        .listen((snapshot) async {

      if (!snapshot.exists) return;

      final data = snapshot.data();

      if (data == null) return;

      status = data["status"] ?? "pending";

      final customerLat =
          (data["pickupLat"] as num).toDouble();

      final customerLng =
          (data["pickupLng"] as num).toDouble();

      final driverLat =
          (data["driverLat"] as num).toDouble();

      final driverLng =
          (data["driverLng"] as num).toDouble();

      markers.clear();

      markers.add(
        Marker(
          markerId: const MarkerId("customer"),
          position: LatLng(
            customerLat,
            customerLng,
          ),
          infoWindow: const InfoWindow(
            title: "أنت",
          ),
        ),
      );

      if (driverLat != 0 && driverLng != 0) {

        final driver = LatLng(
          driverLat,
          driverLng,
        );

        final customer = LatLng(
          customerLat,
          customerLng,
        );

        markers.add(
          Marker(
            markerId: const MarkerId("driver"),
            position: driver,
            infoWindow: const InfoWindow(
              title: "السائق",
            ),
          ),
        );

        final route =
            await DirectionsService.instance.getDirections(
          origin: driver,
          destination: customer,
        );

        polylines.clear();

        if (route != null) {

          distance = route["distanceText"];

          duration = route["durationText"];

          final points =
              DirectionsService.instance.decodePolyline(
            route["polyline"],
          );

          polylines.add(
            Polyline(
              polylineId:
                  const PolylineId("route"),
              width: 6,
              color: const Color(0xff1565C0),
              points: points,
            ),
          );
        }

        if (mapController.isCompleted && firstMove) {

          firstMove = false;

          final map =
              await mapController.future;

          await map.animateCamera(
            CameraUpdate.newLatLngBounds(
              LatLngBounds(
                southwest: LatLng(
                  customerLat < driverLat
                      ? customerLat
                      : driverLat,
                  customerLng < driverLng
                      ? customerLng
                      : driverLng,
                ),
                northeast: LatLng(
                  customerLat > driverLat
                      ? customerLat
                      : driverLat,
                  customerLng > driverLng
                      ? customerLng
                      : driverLng,
                ),
              ),
              120,
            ),
          );
        }
      }

      refresh();
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }
}