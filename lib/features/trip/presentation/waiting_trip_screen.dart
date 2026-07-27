import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../trip/data/trip_service.dart';

class WaitingTripScreen extends StatefulWidget {
  final String tripId;
  final VoidCallback onCancel;

  const WaitingTripScreen({
    super.key,
    required this.tripId,
    required this.onCancel,
  });

  @override
  State<WaitingTripScreen> createState() =>
      _WaitingTripScreenState();
}

class _WaitingTripScreenState
    extends State<WaitingTripScreen> {

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      listener;

  @override
  void initState() {
    super.initState();

    listener = TripService.instance
        .tripStream(widget.tripId)
        .listen((trip) {

      if (!trip.exists) return;

      final data = trip.data();

      if (data == null) return;

      final status = data["status"];

      if (status == "accepted") {

        Navigator.pushReplacementNamed(
          context,
          "/driver-arriving",
          arguments: widget.tripId,
        );
      }
    });
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(

            children: [

              const Spacer(),

              const CircularProgressIndicator(),

              const SizedBox(height: 25),

              const Text(
                "جاري البحث عن سائق",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "سيتم إشعارك فور قبول أحد السائقين",
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),

                  onPressed: widget.onCancel,

                  child: const Text(
                    "إلغاء الطلب",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}