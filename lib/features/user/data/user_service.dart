import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  UserService._();

  static final instance = UserService._();

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth auth =
      FirebaseAuth.instance;
Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
  String uid,
) {
  return FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .get();
}
  Future<void> createUser({
    required String role,
    required String phone,
    String name = "",
  }) async {
    final user = auth.currentUser;

    if (user == null) return;

    final doc =
        firestore.collection("users").doc(user.uid);

    if ((await doc.get()).exists) {
      return;
    }

    await doc.set({
      "uid": user.uid,
      "phone": phone,
      "name": name,
      "role": role,
      "isOnline": false,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final user = auth.currentUser;

    if (user == null) return null;

    final doc = await firestore
        .collection("users")
        .doc(user.uid)
        .get();

    return doc.data();
  }

  Future<void> updateOnlineStatus(
      bool online) async {
    final user = auth.currentUser;

    if (user == null) return;

    await firestore
        .collection("users")
        .doc(user.uid)
        .update({
      "isOnline": online,
    });
  }
}