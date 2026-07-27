import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class LiveTripLocationService {
  LiveTripLocationService._();

  static final instance = LiveTripLocationService._();

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  StreamSubscription<Position>? _subscription;

  Future<void> start({
    required String driverId,
    required String tripId,
  }) async {
    await stop();

    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((position) async {
      final lat = position.latitude;
      final lng = position.longitude;

      /// تحديث موقع السائق
      await firestore
          .collection("drivers")
          .doc(driverId)
          .set({
        "lat": lat,
        "lng": lng,
        "lastSeen": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      /// تحديث موقع السائق داخل الرحلة
      await firestore
          .collection("trips")
          .doc(tripId)
          .update({
        "driverLat": lat,
        "driverLng": lng,
      });
    });
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}