import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(AppUser user) async {
    await firestore
        .collection("users")
        .doc(user.uid)
        .set(user.toMap());
  }

  Future<bool> userExists(String uid) async {
    final doc =
        await firestore.collection("users").doc(uid).get();

    return doc.exists;
  }

  Future<AppUser?> getUser(String uid) async {
    final doc =
        await firestore.collection("users").doc(uid).get();

    if (!doc.exists) return null;

    return AppUser.fromMap(doc.data()!);
  }
}