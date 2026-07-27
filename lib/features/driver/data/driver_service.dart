import 'package:cloud_firestore/cloud_firestore.dart';

import '../../notifications/data/notification_service.dart';

import '../repositories/driver_repository.dart';
import '../../trip/repositories/trip_repository.dart';

class DriverService {
  DriverService._();

  static final instance = DriverService._();

  final driverRepository =
      DriverRepository.instance;

  final tripRepository =
      TripRepository.instance;

  ///==========================
  /// تشغيل السائق
  ///==========================

  Future<void> setDriverOnline({
    required String driverId,
  }) async {
    await driverRepository.updateDriver(
      driverId,
      {
        "isOnline": true,
        "isBusy": false,
        "lastSeen":
            FieldValue.serverTimestamp(),
      },
    );
  }

  ///==========================
  /// إيقاف السائق
  ///==========================

  Future<void> setDriverOffline({
    required String driverId,
  }) async {
    await driverRepository.updateDriver(
      driverId,
      {
        "isOnline": false,
        "isBusy": false,
        "lastSeen":
            FieldValue.serverTimestamp(),
      },
    );
  }

  ///==========================
  /// تحديث موقع السائق
  ///==========================

  Future<void> updateDriverLocation({
    required String driverId,
    required double lat,
    required double lng,
  }) async {
    await driverRepository.updateDriver(
      driverId,
      {
        "lat": lat,
        "lng": lng,
        "lastSeen":
            FieldValue.serverTimestamp(),
      },
    );
  }

  ///==========================
  /// تغيير حالة الانشغال
  ///==========================

  Future<void> setBusy({
    required String driverId,
    required bool busy,
  }) async {
    await driverRepository.updateDriver(
      driverId,
      {
        "isBusy": busy,
      },
    );
  }
    ///==========================
  /// قبول الرحلة
  ///==========================

  Future<void> acceptTrip({
    required String tripId,
    required String driverId,
  }) async {
    await tripRepository.acceptTrip(
      tripId: tripId,
      driverId: driverId,
    );

    await setBusy(
      driverId: driverId,
      busy: true,
    );
  }

  ///==========================
  /// رفض الرحلة
  ///==========================

  Future<void> rejectTrip(
    String tripId,
  ) async {
    await tripRepository.update(
      tripId,
      {
        "status": "rejected",
      },
    );
  }

  ///==========================
  /// بيانات السائق
  ///==========================

  Future<DocumentSnapshot<Map<String, dynamic>>>
      driverData(
    String driverId,
  ) {
    return driverRepository.driver(
      driverId,
    );
  }

  ///==========================
  /// تحديث موقع السائق داخل الرحلة
  ///==========================

  Future<void> updateTripDriverLocation({
    required String tripId,
    required double lat,
    required double lng,
  }) async {
    await tripRepository.update(
      tripId,
      {
        "driverLat": lat,
        "driverLng": lng,
        "driverLocationUpdatedAt":
            FieldValue.serverTimestamp(),
      },
    );
  }
    ///==========================
  /// وصل إلى العميل
  ///==========================

  Future<void> arrivedToPickup(
    String tripId,
  ) async {
    final trip =
        await tripRepository.trip(tripId);

    final customerId =
        trip["customerId"];

    await tripRepository.update(
      tripId,
      {
        "status": "arrived",
        "arrivedAt":
            FieldValue.serverTimestamp(),
      },
    );

    await NotificationService.instance
        .createTripNotification(
      userId: customerId,
      tripId: tripId,
      title: "السائق وصل",
      body:
          "السائق بانتظارك في نقطة الانطلاق.",
    );
  }

  ///==========================
  /// بدء الرحلة
  ///==========================

  Future<void> startTrip(
    String tripId,
  ) async {
    final trip =
        await tripRepository.trip(tripId);

    final customerId =
        trip["customerId"];

    await tripRepository.update(
      tripId,
      {
        "status": "on_trip",
        "startedAt":
            FieldValue.serverTimestamp(),
      },
    );

    await NotificationService.instance
        .createTripNotification(
      userId: customerId,
      tripId: tripId,
      title: "بدأت الرحلة",
      body:
          "تم بدء رحلتك مع السائق.",
    );
  }
    ///==========================
  /// إنهاء الرحلة
  ///==========================

  Future<void> finishTrip({
    required String tripId,
    required String driverId,
  }) async {
    final trip =
        await tripRepository.trip(tripId);

    final customerId =
        trip["customerId"];

    await tripRepository.update(
      tripId,
      {
        "status": "completed",
        "completedAt":
            FieldValue.serverTimestamp(),
      },
    );

    await NotificationService.instance
        .createTripNotification(
      userId: customerId,
      tripId: tripId,
      title: "انتهت الرحلة",
      body:
          "شكراً لاستخدام Oma، نتمنى أن تكون رحلتك ممتعة.",
    );

    await setBusy(
      driverId: driverId,
      busy: false,
    );
  }

  ///==========================
  /// إلغاء الرحلة
  ///==========================

  Future<void> cancelTrip({
    required String tripId,
    required String driverId,
  }) async {
    final trip =
        await tripRepository.trip(tripId);

    final customerId =
        trip["customerId"];

    await tripRepository.update(
      tripId,
      {
        "status": "cancelled",
        "driverCancelled": true,
        "cancelledAt":
            FieldValue.serverTimestamp(),
      },
    );

    await NotificationService.instance
        .createTripNotification(
      userId: customerId,
      tripId: tripId,
      title: "تم إلغاء الرحلة",
      body:
          "قام السائق بإلغاء الرحلة، وسيتم البحث عن سائق آخر.",
    );

    await setBusy(
      driverId: driverId,
      busy: false,
    );
  }
    ///==========================
  /// تحديث موقع السائق داخل الرحلة + داخل حساب السائق
  ///==========================

  Future<void> updateLiveLocation({
  required String driverId,
  required String tripId,
  required double lat,
  required double lng,
}) async {
  // تحديث موقع السائق في حسابه
  await updateDriverLocation(
    driverId: driverId,
    lat: lat,
    lng: lng,
  );

  // تحديث موقع السائق داخل الرحلة
  await updateTripDriverLocation(
    tripId: tripId,
    lat: lat,
    lng: lng,
  );
}
}