import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/models/trip_model.dart';
import '../../../core/services/driver_location_service.dart';

import '../data/driver_service.dart';
import '../data/nearby_trip_service.dart';

import 'widgets/incoming_trip_dialog.dart';
import '../widgets/trip_card.dart';

import 'driver_trip_screen.dart';
import '../../notifications/data/notification_service.dart';
class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() =>
      _DriverHomeScreenState();
}

class _DriverHomeScreenState
    extends State<DriverHomeScreen> {

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  bool isOnline = false;

  bool _dialogOpened = false;

  @override
  void dispose() {
    DriverLocationService.instance.stop(
      driverId: auth.currentUser?.uid ?? "",
    );
    super.dispose();
  }

  Future<void> _changeOnline(
    bool value,
  ) async {

    final user = auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "يجب تسجيل الدخول أولاً",
          ),
        ),
      );
      return;
    }

    setState(() {
      isOnline = value;
    });

    if (value) {

      await DriverService.instance.setDriverOnline(
        driverId: user.uid,
      );

      await DriverLocationService.instance.start(
        driverId: user.uid,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("أنت الآن متصل"),
        ),
      );

    } else {

      await DriverService.instance.setDriverOffline(
        driverId: user.uid,
      );

      await DriverLocationService.instance.stop(
        driverId: user.uid,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "تم إيقاف استقبال الطلبات",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "طلبات الرحلات",
        ),
        centerTitle: true,

        actions: [

          Row(
            children: [

              Text(
                isOnline
                    ? "متصل"
                    : "غير متصل",
              ),

              Switch(
                value: isOnline,
                onChanged: _changeOnline,
              ),

              const SizedBox(width: 10),
            ],
          ),
        ],
      ),

      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: DriverService.instance.driverData(
          auth.currentUser!.uid,
        ),

        builder: (context, driverSnapshot) {

          if (driverSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!driverSnapshot.hasData ||
              driverSnapshot.data?.data() == null) {
            return const Center(
              child: Text(
                "لا توجد بيانات للسائق",
              ),
            );
          }

          final driver =
              driverSnapshot.data!.data()!;

          final driverLat =
              (driver["lat"] as num?)?.toDouble() ?? 0;

          final driverLng =
              (driver["lng"] as num?)?.toDouble() ?? 0;

          return StreamBuilder<
              List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: NearbyTripService.instance.nearbyTrips(
              driverLat: driverLat,
              driverLng: driverLng,
            ),

            builder: (context, snapshot) {

  if (snapshot.connectionState ==
      ConnectionState.waiting) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (!snapshot.hasData ||
      snapshot.data!.isEmpty) {

    _dialogOpened = false;

    return const Center(
      child: Text("لا توجد طلبات حالياً"),
    );
  }

  final docs = snapshot.data!;

          final firstTrip = TripModel.fromFirestore(docs.first);

          if (!_dialogOpened && isOnline) {
            _dialogOpened = true;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return IncomingTripDialog(
                    trip: docs.first.data(),

                    onAccept: () async {
                      Navigator.pop(context);

                      try {
                        await DriverService.instance.acceptTrip(
                          tripId: firstTrip.id,
                          driverId: auth.currentUser!.uid,
                        );
                        await NotificationService.instance.createTripNotification(
  userId: firstTrip.customerId,
  tripId: firstTrip.id,
  title: "تم قبول الرحلة",
  body: "قام أحد السائقين بقبول طلب رحلتك.",
);
                      } catch (_) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "تم قبول الرحلة بواسطة سائق آخر",
                            ),
                          ),
                        );

                        _dialogOpened = false;
                        return;
                      }

                      if (!mounted) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DriverTripScreen(
                            tripId: firstTrip.id,
                            phone: firstTrip.customerPhone,
                            pickup: firstTrip.pickupAddress,
                            destination:
                                firstTrip.destinationAddress,
                            distance:
                                "${firstTrip.distance} متر",
                            duration:
                                "${firstTrip.duration} ثانية",
                            price:
                                "${firstTrip.price.toStringAsFixed(0)} د.ع",
                            customerLat:
                                firstTrip.pickupLat,
                            customerLng:
                                firstTrip.pickupLng,
                          ),
                        ),
                      );

                      _dialogOpened = false;
                    },

                    onReject: () async {
                      Navigator.pop(context);

                      await DriverService.instance.rejectTrip(
                        firstTrip.id,
                      );
await NotificationService.instance.createTripNotification(
  userId: firstTrip.customerId,
  tripId: firstTrip.id,
  title: "تم رفض الرحلة",
  body: "قام أحد السائقين برفض الرحلة، وسيتم البحث عن سائق آخر.",
);
                      _dialogOpened = false;
                    },
                  );
                },
              );
            });
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final trip =
                  TripModel.fromFirestore(docs[index]);

              return TripCard(
                tripId: trip.id,
                phone: trip.customerPhone,
                pickup: trip.pickupAddress,
                destination:
                    trip.destinationAddress,
                distance:
                    "${trip.distance} متر",
                duration:
                    "${trip.duration} ثانية",
                price:
                    "${trip.price.toStringAsFixed(0)} د.ع",

                onAccept: () async {
                  try {
                    await DriverService.instance.acceptTrip(
                      tripId: trip.id,
                      driverId: auth.currentUser!.uid,
                    );
                  } catch (_) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "تم قبول الرحلة بواسطة سائق آخر",
                        ),
                      ),
                    );

                    return;
                  }

                  if (!mounted) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DriverTripScreen(
                        tripId: trip.id,
                        phone: trip.customerPhone,
                        pickup: trip.pickupAddress,
                        destination:
                            trip.destinationAddress,
                        distance:
                            "${trip.distance} متر",
                        duration:
                            "${trip.duration} ثانية",
                        price:
                            "${trip.price.toStringAsFixed(0)} د.ع",
                        customerLat:
                            trip.pickupLat,
                        customerLng:
                            trip.pickupLng,
                      ),
                    ),
                  );
                },

                onReject: () async {
                  await DriverService.instance.rejectTrip(
                    trip.id,
                  );

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("تم رفض الرحلة"),
                    ),
                  );
                },
              );
            },
          );
                    },
          );
        },
      ),
    );
  }
}
