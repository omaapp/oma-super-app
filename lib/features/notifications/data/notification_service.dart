import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_notification_model.dart';

class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
      _collection(String userId) {
    return firestore
        .collection("users")
        .doc(userId)
        .collection("notifications");
  }
Future<void> createTripNotification({
  required String userId,
  required String title,
  required String body,
  required String tripId,
}) async {
  await addNotification(
    userId: userId,
    title: title,
    body: body,
    type: "trip",
    tripId: tripId,
  );
}
  /// إضافة إشعار جديد
  Future<void> addNotification({
    required String userId,
    required String title,
    required String body,
    required String type,
    String? tripId,
  }) async {
    await _collection(userId).add({
      "title": title,
      "body": body,
      "type": type,
      "tripId": tripId,
      "isRead": false,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// جميع الإشعارات
  Stream<List<AppNotificationModel>>
      notifications(String userId) {
    return _collection(userId)
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                AppNotificationModel.fromFirestore,
              )
              .toList(),
        );
  }

  /// عدد غير المقروءة
  Stream<int> unreadCount(String userId) {
    return _collection(userId)
        .where(
          "isRead",
          isEqualTo: false,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.length,
        );
  }

  /// تعليم كمقروء
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    await _collection(userId)
        .doc(notificationId)
        .update({
      "isRead": true,
    });
  }

  /// حذف إشعار
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    await _collection(userId)
        .doc(notificationId)
        .delete();
  }

  /// حذف جميع الإشعارات
  Future<void> clearNotifications(
    String userId,
  ) async {
    final docs =
        await _collection(userId).get();

    final batch = firestore.batch();

    for (final doc in docs.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}