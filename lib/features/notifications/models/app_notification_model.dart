import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotificationModel {
  final String id;

  final String title;

  final String body;

  final String type;

  final bool isRead;

  final String? tripId;

  final Timestamp createdAt;

  AppNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.tripId,
  });

  factory AppNotificationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return AppNotificationModel(
      id: doc.id,
      title: data["title"] ?? "",
      body: data["body"] ?? "",
      type: data["type"] ?? "general",
      isRead: data["isRead"] ?? false,
      tripId: data["tripId"],
      createdAt:
          data["createdAt"] ??
          Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "body": body,
      "type": type,
      "isRead": isRead,
      "tripId": tripId,
      "createdAt": createdAt,
    };
  }
}