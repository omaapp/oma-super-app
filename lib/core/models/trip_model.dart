import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;

  final String customerId;
  final String customerPhone;

  final String driverId;

  final double pickupLat;
  final double pickupLng;

  final double destinationLat;
  final double destinationLng;

  final String pickupAddress;
  final String destinationAddress;

  final double price;

  final int distance;
  final int duration;

  final String status;

  final DateTime? createdAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;

  const TripModel({
    required this.id,
    required this.customerId,
    required this.customerPhone,
    required this.driverId,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.price,
    required this.distance,
    required this.duration,
    required this.status,
    this.createdAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
  });

  factory TripModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return TripModel(
      id: doc.id,

      customerId: data["customerId"] ?? "",
      customerPhone: data["customerPhone"] ?? "",

      driverId: data["driverId"] ?? "",

      pickupLat: (data["pickupLat"] ?? 0).toDouble(),
      pickupLng: (data["pickupLng"] ?? 0).toDouble(),

      destinationLat:
          (data["destinationLat"] ?? 0).toDouble(),
      destinationLng:
          (data["destinationLng"] ?? 0).toDouble(),

      pickupAddress: data["pickupAddress"] ?? "",
      destinationAddress:
          data["destinationAddress"] ?? "",

      price: (data["price"] ?? 0).toDouble(),

      distance: data["distance"] ?? 0,
      duration: data["duration"] ?? 0,

      status: data["status"] ?? "pending",

      createdAt:
          (data["createdAt"] as Timestamp?)
              ?.toDate(),

      acceptedAt:
          (data["acceptedAt"] as Timestamp?)
              ?.toDate(),

      startedAt:
          (data["startedAt"] as Timestamp?)
              ?.toDate(),

      completedAt:
          (data["completedAt"] as Timestamp?)
              ?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "customerId": customerId,
      "customerPhone": customerPhone,
      "driverId": driverId,

      "pickupLat": pickupLat,
      "pickupLng": pickupLng,

      "destinationLat": destinationLat,
      "destinationLng": destinationLng,

      "pickupAddress": pickupAddress,
      "destinationAddress": destinationAddress,

      "price": price,
      "distance": distance,
      "duration": duration,

      "status": status,

      "createdAt": createdAt,
      "acceptedAt": acceptedAt,
      "startedAt": startedAt,
      "completedAt": completedAt,
    };
  }

  TripModel copyWith({
    String? driverId,
    String? status,
    double? price,
    int? distance,
    int? duration,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) {
    return TripModel(
      id: id,
      customerId: customerId,
      customerPhone: customerPhone,
      driverId: driverId ?? this.driverId,
      pickupLat: pickupLat,
      pickupLng: pickupLng,
      destinationLat: destinationLat,
      destinationLng: destinationLng,
      pickupAddress: pickupAddress,
      destinationAddress: destinationAddress,
      price: price ?? this.price,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      createdAt: createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt:
          completedAt ?? this.completedAt,
    );
  }
}