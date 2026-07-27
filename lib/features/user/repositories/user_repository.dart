import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/firestore_service.dart';

class UserRepository {
  UserRepository._();

  static final instance =
      UserRepository._();

  final firestore =
      FirestoreService.instance;

  Future<void> create(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await firestore
        .users()
        .doc(uid)
        .set(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      get(
    String uid,
  ) {
    return firestore
        .users()
        .doc(uid)
        .get();
  }

  Future<void> update(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await firestore
        .users()
        .doc(uid)
        .update(data);
  }
}