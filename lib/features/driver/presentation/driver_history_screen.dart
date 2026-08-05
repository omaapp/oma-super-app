import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverHistoryScreen extends StatelessWidget {
  const DriverHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final driverId =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("سجل الرحلات"),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("trips")
            .where("driverId", isEqualTo: driverId)
            .where("status", isEqualTo: "completed")
            .orderBy(
              "completedAt",
              descending: true,
            )
            .snapshots(),
                    builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "لا توجد رحلات منتهية",
              ),
            );
          }

          final trips = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trips.length,
            itemBuilder: (context, index) {

              final trip =
                  trips[index].data() as Map<String, dynamic>;

              return Card(
                margin:
                    const EdgeInsets.only(
                  bottom: 16,
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(18),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        trip["customerName"] ??
                            "عميل",
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "من : ${trip["pickupAddress"]}",
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "إلى : ${trip["destinationAddress"]}",
                      ),

                      const SizedBox(height: 10),
                                            Row(
                        children: [

                          const Icon(
                            Icons.payments,
                            color: Colors.green,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            "${trip["price"]} د.ع",
                          ),

                          const Spacer(),

                          const Icon(
                            Icons.route,
                            color: Colors.blue,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            "${trip["distance"]} م",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}