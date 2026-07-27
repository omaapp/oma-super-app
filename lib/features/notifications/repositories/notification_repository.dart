import '../../../core/firebase/firestore_service.dart';

class NotificationRepository {
  NotificationRepository._();

  static final instance =
      NotificationRepository._();

  final firestore =
      FirestoreService.instance;

  Future<void> create({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await firestore
        .notifications()
        .doc(userId)
        .collection("items")
        .add(data);
  }
}