import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class DriverLocationService {
  DriverLocationService._();

  static final instance = DriverLocationService._();

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  StreamSubscription<Position>? _subscription;

  Future<void> startSharingLocation() async {
    final user = auth.currentUser;

    if (user == null) return;

    _subscription?.cancel();

    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    ).listen((Position position) async {
      await firestore
          .collection("drivers")
          .doc(user.uid)
          .set({
        "lat": position.latitude,
        "lng": position.longitude,
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }

  Future<void> stopSharingLocation() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}