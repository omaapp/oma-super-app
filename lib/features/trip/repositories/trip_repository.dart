import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/firestore_service.dart';

class TripRepository {
  TripRepository._();

  static final instance = TripRepository._();

  final firestore = FirestoreService.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> pendingTrips() {
    return firestore
        .trips()
        .where(
          "status",
          isEqualTo: "pending",
        )
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> trip(
    String id,
  ) {
    return firestore
        .trips()
        .doc(id)
        .get();
  }

  Future<void> update(
    String tripId,
    Map<String, dynamic> data,
  ) async {
    await firestore
        .trips()
        .doc(tripId)
        .update(data);
  }

  Future<void> create(
    Map<String, dynamic> data,
  ) async {
    await firestore
        .trips()
        .add(data);
  }
  Future<void> updateStatus(
  String tripId,
  String status,
) async {
  await firestore
      .trips()
      .doc(tripId)
      .update({
    "status": status,
  });
}
Future<void> setDriver(
  String tripId,
  String driverId,
) async {
  await firestore
      .trips()
      .doc(tripId)
      .update({
    "driverId": driverId,
    "acceptedDriverId": driverId,
    "acceptedAt": FieldValue.serverTimestamp(),
    "status": "accepted",
  });
}
Future<void> acceptTrip({
  required String tripId,
  required String driverId,
}) async {
  final tripRef = firestore
      .trips()
      .doc(tripId);

  await FirebaseFirestore.instance.runTransaction(
    (tx) async {
      final snapshot = await tx.get(tripRef);

      if (!snapshot.exists) {
        throw Exception("Trip not found");
      }

      final data = snapshot.data()!;

      if (data["status"] != "pending") {
        throw Exception("Trip already accepted");
      }

      tx.update(
        tripRef,
        {
          "status": "accepted",
          "driverId": driverId,
          "acceptedDriverId": driverId,
          "acceptedAt":
              FieldValue.serverTimestamp(),
        },
      );
    },
  );
}
}