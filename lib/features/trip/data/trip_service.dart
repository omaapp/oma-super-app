import 'package:cloud_firestore/cloud_firestore.dart';

class TripService {
  TripService._();

  static final instance = TripService._();

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<String> createTrip({
    required String customerId,
    required String phone,

    required double pickupLat,
    required double pickupLng,

    required double destinationLat,
    required double destinationLng,

    required String pickupAddress,
    required String destinationAddress,

    required String vehicleType,

    required double price,

    required int distance,

    required int duration,
  }) async {
    final doc =
        firestore.collection("trips").doc();

    await doc.set({
      ///==========================
      /// بيانات العميل
      ///==========================

      "customerId": customerId,
      "customerPhone": phone,

      ///==========================
      /// بيانات السائق
      ///==========================

      "driverId": "",
      "driverName": "",
      "driverPhone": "",

      /// أول سائق يقبل الرحلة
      "acceptedDriverId": "",

      ///==========================
      /// نوع المركبة
      ///==========================

      "vehicleType": vehicleType,

      ///==========================
      /// نقطة الانطلاق
      ///==========================

      "pickupLat": pickupLat,
      "pickupLng": pickupLng,
      "pickupAddress": pickupAddress,

      ///==========================
      /// الوجهة
      ///==========================

      "destinationLat": destinationLat,
      "destinationLng": destinationLng,
      "destinationAddress": destinationAddress,

      ///==========================
      /// تفاصيل الرحلة
      ///==========================

      "price": price,
      "distance": distance,
      "duration": duration,

      ///==========================
      /// البحث عن السائق
      ///==========================

      /// نصف قطر البحث بالمتر
      "searchRadius": 5000,

      ///==========================
      /// حالة الرحلة
      ///==========================

      /// pending
      /// accepted
      /// arrived
      /// on_trip
      /// completed
      /// cancelled

      "status": "pending",

      ///==========================
      /// إلغاء الرحلة
      ///==========================

      "customerCancelled": false,
      "driverCancelled": false,

      ///==========================
      /// الموقع المباشر
      ///==========================

      "driverLat": 0.0,
      "driverLng": 0.0,

      ///==========================
      /// التوقيت
      ///==========================

      "createdAt":
          FieldValue.serverTimestamp(),

      "acceptedAt": null,

      "arrivedAt": null,

      "startedAt": null,

      "completedAt": null,

      "cancelledAt": null,
    });

    return doc.id;
  }

  Future<void> updateTripStatus({
    required String tripId,
    required String status,
  }) async {
    await firestore
        .collection("trips")
        .doc(tripId)
        .update({
      "status": status,
    });
  }

  Future<void> assignDriver({
    required String tripId,
    required String driverId,
    required String driverName,
    required String driverPhone,
  }) async {
    await firestore
        .collection("trips")
        .doc(tripId)
        .update({
      "driverId": driverId,
      "driverName": driverName,
      "driverPhone": driverPhone,

      "acceptedDriverId": driverId,

      "status": "accepted",

      "acceptedAt":
          FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDriverLocation({
    required String tripId,
    required double lat,
    required double lng,
  }) async {
    await firestore
        .collection("trips")
        .doc(tripId)
        .update({
      "driverLat": lat,
      "driverLng": lng,
    });
  }

  Future<void> cancelByCustomer(
      String tripId) async {
    await firestore
        .collection("trips")
        .doc(tripId)
        .update({
      "customerCancelled": true,
      "status": "cancelled",
      "cancelledAt":
          FieldValue.serverTimestamp(),
    });
  }

  Future<void> cancelByDriver(
      String tripId) async {
    await firestore
        .collection("trips")
        .doc(tripId)
        .update({
      "driverCancelled": true,
      "status": "cancelled",
      "cancelledAt":
          FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      pendingTrips() {
    return firestore
        .collection("trips")
        .where(
          "status",
          isEqualTo: "pending",
        )
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>
      tripStream(String tripId) {
    return firestore
        .collection("trips")
        .doc(tripId)
        .snapshots();
  }
  /// قبول الرحلة بواسطة السائق
Future<void> acceptTrip({
  required String tripId,
  required String driverId,
  required String driverName,
  required String driverPhone,
}) async {
  await firestore.collection("trips").doc(tripId).update({
    "status": "accepted",
    "driverId": driverId,
    "driverName": driverName,
    "driverPhone": driverPhone,
    "acceptedAt": FieldValue.serverTimestamp(),
  });
}

/// وصول السائق
Future<void> driverArrived(String tripId) async {
  await firestore.collection("trips").doc(tripId).update({
    "status": "arrived",
    "arrivedAt": FieldValue.serverTimestamp(),
  });
}

/// بدء الرحلة
Future<void> startTrip(String tripId) async {
  await firestore.collection("trips").doc(tripId).update({
    "status": "on_trip",
    "startedAt": FieldValue.serverTimestamp(),
  });
}

/// إنهاء الرحلة
Future<void> finishTrip(String tripId) async {
  await firestore.collection("trips").doc(tripId).update({
    "status": "completed",
    "completedAt": FieldValue.serverTimestamp(),
  });
}
Future<void> cancelTrip(String id) async {
  await firestore
      .collection("trips")
      .doc(id)
      .update({
    "status": "cancelled",
    "cancelledAt": FieldValue.serverTimestamp(),
  });
}
/// تحديث موقع السائق باستمرار
Future<void> updateDriverLiveLocation({
  required String tripId,
  required double lat,
  required double lng,
}) async {
  await firestore.collection("trips").doc(tripId).update({
    "driverLat": lat,
    "driverLng": lng,
  });
}
}