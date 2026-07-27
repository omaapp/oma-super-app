import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/services/directions_service.dart';

class DriverTripMapController {
  DriverTripMapController({
    required this.customerLat,
    required this.customerLng,
  });

  final double customerLat;
  final double customerLng;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  final Set<Marker> markers = {};

  final Set<Polyline> polylines = {};

  StreamSubscription<Position>? _subscription;

  bool _firstCameraMove = true;

  String distance = "--";

  String duration = "--";

  Future<void> start(
    VoidCallback refresh,
  ) async {
    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((position) async {
      final driver = LatLng(
        position.latitude,
        position.longitude,
      );

      final customer = LatLng(
        customerLat,
        customerLng,
      );

      markers
        ..clear()
        ..add(
          Marker(
            markerId: const MarkerId("driver"),
            position: driver,
            infoWindow: const InfoWindow(
              title: "السائق",
            ),
          ),
        )
        ..add(
          Marker(
            markerId: const MarkerId("customer"),
            position: customer,
            infoWindow: const InfoWindow(
              title: "العميل",
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
      polylineId: const PolylineId("route"),
      points: points,
      width: 6,
      color: const Color(0xff1565C0),
    ),
  );
}

      refresh();

      if (mapController.isCompleted && _firstCameraMove) {
        _firstCameraMove = false;

        final map = await mapController.future;

        await map.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                driver.latitude < customer.latitude
                    ? driver.latitude
                    : customer.latitude,
                driver.longitude < customer.longitude
                    ? driver.longitude
                    : customer.longitude,
              ),
              northeast: LatLng(
                driver.latitude > customer.latitude
                    ? driver.latitude
                    : customer.latitude,
                driver.longitude > customer.longitude
                    ? driver.longitude
                    : customer.longitude,
              ),
            ),
            120,
          ),
        );
      }
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }
}