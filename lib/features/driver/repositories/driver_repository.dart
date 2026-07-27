import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/firestore_service.dart';

class DriverRepository {
  DriverRepository._();

  static final instance =
      DriverRepository._();

  final firestore =
      FirestoreService.instance;

  Future<void> updateDriver(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await firestore
        .drivers()
        .doc(uid)
        .set(
          data,
          SetOptions(
            merge: true,
          ),
        );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      driver(
    String uid,
  ) {
    return firestore
        .drivers()
        .doc(uid)
        .get();
  }
}