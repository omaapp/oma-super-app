import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  final FirebaseFirestore db =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> users() {
    return db.collection("users");
  }

  CollectionReference<Map<String, dynamic>> drivers() {
    return db.collection("drivers");
  }

  CollectionReference<Map<String, dynamic>> trips() {
    return db.collection("trips");
  }

  CollectionReference<Map<String, dynamic>> notifications() {
    return db.collection("notifications");
  }

  CollectionReference<Map<String, dynamic>> settings() {
    return db.collection("settings");
  }
}