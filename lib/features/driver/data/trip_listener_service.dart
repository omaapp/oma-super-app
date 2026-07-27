import 'package:cloud_firestore/cloud_firestore.dart';

class TripListenerService {
  TripListenerService._();

  static final instance = TripListenerService._();

  Stream<DocumentSnapshot<Map<String, dynamic>>> listenTrip(
    String tripId,
  ) {
    return FirebaseFirestore.instance
        .collection("trips")
        .doc(tripId)
        .snapshots();
  }
}