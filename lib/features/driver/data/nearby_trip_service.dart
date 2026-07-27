import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../../trip/data/trip_service.dart';

class NearbyTripService {
  NearbyTripService._();

  static final instance = NearbyTripService._();

  final _controller =
      StreamController<List<QueryDocumentSnapshot<Map<String, dynamic>>>>.broadcast();

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> nearbyTrips({
    required double driverLat,
    required double driverLng,
  }) {
    TripService.instance.pendingTrips().listen((snapshot) {
      final result =
          <QueryDocumentSnapshot<Map<String, dynamic>>>[];

      for (final trip in snapshot.docs) {
        final data = trip.data();

        final pickupLat =
            (data["pickupLat"] as num).toDouble();

        final pickupLng =
            (data["pickupLng"] as num).toDouble();

        final radius =
            (data["searchRadius"] as num).toDouble();

        final distance =
            Geolocator.distanceBetween(
          driverLat,
          driverLng,
          pickupLat,
          pickupLng,
        );

        if (distance <= radius) {
          result.add(trip);
        }
      }

      _controller.add(result);
    });

    return _controller.stream;
  }

  void dispose() {
    _controller.close();
  }
}