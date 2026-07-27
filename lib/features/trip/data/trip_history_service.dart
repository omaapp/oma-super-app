import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TripHistoryService {
  TripHistoryService._();

  static final instance = TripHistoryService._();

  final firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> trips() {
    return firestore
        .collection("trips")
        .where(
          "customerId",
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }
}