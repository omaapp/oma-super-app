import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //================ Collections ================

  CollectionReference<Map<String, dynamic>> users() {
    return firestore.collection("users");
  }

  CollectionReference<Map<String, dynamic>> trips() {
    return firestore.collection("trips");
  }

  CollectionReference<Map<String, dynamic>> drivers() {
    return firestore.collection("drivers");
  }

  CollectionReference<Map<String, dynamic>> notifications(
    String userId,
  ) {
    return users().doc(userId).collection("notifications");
  }

  //================ Users ================

  Future<void> createUser(AppUser user) async {
    await users().doc(user.uid).set(user.toMap());
  }

  Future<bool> userExists(String uid) async {
    final doc = await users().doc(uid).get();

    return doc.exists;
  }

  Future<AppUser?> getUser(String uid) async {
    final doc = await users().doc(uid).get();

    if (!doc.exists) return null;

    return AppUser.fromMap(doc.data()!);
  }
}