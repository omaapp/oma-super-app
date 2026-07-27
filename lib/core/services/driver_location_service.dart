import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DriverLocationService {
  DriverLocationService._();

  static final instance = DriverLocationService._();

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  StreamSubscription<Position>? _subscription;

  Future<void> start({
    required String driverId,
  }) async {

    _subscription?.cancel();

    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen((position) async {

      await firestore
          .collection("drivers")
          .doc(driverId)
          .set({

        "lat": position.latitude,

        "lng": position.longitude,

        "isOnline": true,

        "updatedAt":
            FieldValue.serverTimestamp(),

      }, SetOptions(merge: true));

    });

  }

  Future<void> stop({
    required String driverId,
  }) async {

    await _subscription?.cancel();

    _subscription = null;

    await firestore
        .collection("drivers")
        .doc(driverId)
        .set({

      "isOnline": false,

      "updatedAt":
          FieldValue.serverTimestamp(),

    }, SetOptions(merge: true));

  }
}