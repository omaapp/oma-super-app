import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String phone;
  final String? name;
  final String role;
  final bool active;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    required this.phone,
    this.name,
    required this.role,
    required this.active,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "phone": phone,
      "name": name,
      "role": role,
      "active": active,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map["uid"],
      phone: map["phone"],
      name: map["name"],
      role: map["role"],
      active: map["active"] ?? true,
      createdAt: (map["createdAt"] as Timestamp).toDate(),
    );
  }
}