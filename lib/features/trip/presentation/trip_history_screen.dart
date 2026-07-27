import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/trip_history_service.dart';
import 'widgets/empty_trip_history.dart';
import 'widgets/trip_history_card.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سجل الرحلات"),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: TripHistoryService.instance.trips(),

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const EmptyTripHistory();
          }

          final trips = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 25,
            ),
            itemCount: trips.length,

            itemBuilder: (context, index) {
              final data = trips[index].data();

              final Timestamp? ts =
                  data["createdAt"] as Timestamp?;

              final String date =
                  ts == null
                      ? "-"
                      : DateFormat(
                          "yyyy/MM/dd  HH:mm",
                        ).format(ts.toDate());

              return TripHistoryCard(
                pickup:
                    data["pickupAddress"] ?? "",

                destination:
                    data["destinationAddress"] ?? "",

                status:
                    data["status"] ?? "pending",

                date: date,

                distance:
                    "${data["distance"] ?? 0} متر",

                duration:
                    "${data["duration"] ?? 0} ثانية",

                price:
                    "${(data["price"] ?? 0).toString()} د.ع",

                onTap: () {
                  // لاحقاً:
                  // شاشة تفاصيل الرحلة
                  // أو إعادة الحجز
                },
              );
            },
          );
        },
      ),
    );
  }
}