import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverEarningsScreen extends StatelessWidget {
  const DriverEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final driverId =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      appBar: AppBar(
        title: const Text("الأرباح"),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("trips")
            .where("driverId", isEqualTo: driverId)
            .where("status", isEqualTo: "completed")
            .snapshots(),
                    builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {

            return const SizedBox();
          }

          final docs = snapshot.data!.docs;

          double total = 0;

          double today = 0;

          double week = 0;

          double month = 0;

          final now = DateTime.now();
                    for (final doc in docs) {

            final trip =
                doc.data()
                    as Map<String, dynamic>;

            final price =
                (trip["price"] as num?)?.toDouble() ??
                0;

            total += price;

            final ts =
                trip["completedAt"];

            if (ts is Timestamp) {

              final date = ts.toDate();

              if (date.year == now.year &&
                  date.month == now.month) {

                month += price;

                if (date.day == now.day) {

                  today += price;
                }
              }

              if (now.difference(date).inDays <= 7) {

                week += price;
              }
            }
          }
                    Widget card(
            String title,
            double value,
            Color color,
            IconData icon,
          ) {

            return Container(

              margin:
                  const EdgeInsets.only(bottom: 18),

              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: color.withOpacity(.08),
                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Row(

                children: [

                  Icon(
                    icon,
                    color: color,
                    size: 35,
                  ),

                  const SizedBox(width: 15),

                  Expanded(

                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  Text(
                    "${value.toStringAsFixed(0)} د.ع",
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
                    return ListView(

            padding:
                const EdgeInsets.all(20),

            children: [

              card(
                "أرباح اليوم",
                today,
                Colors.green,
                Icons.today,
              ),

              card(
                "أرباح الأسبوع",
                week,
                Colors.blue,
                Icons.date_range,
              ),

              card(
                "أرباح الشهر",
                month,
                Colors.orange,
                Icons.calendar_month,
              ),

              card(
                "إجمالي الأرباح",
                total,
                Colors.purple,
                Icons.account_balance_wallet,
              ),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.route,
                  ),
                  title: const Text(
                    "عدد الرحلات",
                  ),
                  trailing: Text(
                    docs.length.toString(),
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}