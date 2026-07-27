import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/driver_service.dart';
import '../../trip/presentation/driver_arriving_screen.dart';

class DriverRequestsScreen extends StatefulWidget {
  final String driverId;

  const DriverRequestsScreen({
    super.key,
    required this.driverId,
  });

  @override
  State<DriverRequestsScreen> createState() =>
      _DriverRequestsScreenState();
}

class _DriverRequestsScreenState
    extends State<DriverRequestsScreen> {

  StreamSubscription<QuerySnapshot>? subscription;

  List<QueryDocumentSnapshot> requests = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    listenRequests();
  }

  void listenRequests() {
    subscription = FirebaseFirestore.instance
        .collection("trips")
        .where("status", isEqualTo: "pending")
        .where("vehicleType", isEqualTo: "taxi")
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;

      setState(() {
        requests = snapshot.docs;
        loading = false;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("طلبات الرحلات"),
        centerTitle: true,
      ),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : requests.isEmpty
              ? const Center(
                  child: Text(
                    "لا توجد طلبات حالياً",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final trip = requests[index].data()
                        as Map<String, dynamic>;

                    return Card(
                      margin:
                          const EdgeInsets.only(bottom: 16),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),

                      child: Padding(
                        padding:
                            const EdgeInsets.all(18),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            const Text(
                              "طلب رحلة جديد",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Row(
                              children: [

                                const Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    trip["customerName"] ??
                                        "عميل",
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [

                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    trip["pickupAddress"] ??
                                        "",
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [

                                const Icon(
                                  Icons.flag,
                                  color: Colors.green,
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    trip["destinationAddress"] ??
                                        "",
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                                                        Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.check),
                                    label: const Text("قبول"),

                                    onPressed: () async {
                                      await DriverService.instance
                                          .acceptTrip(
                                        tripId:
                                            requests[index].id,
                                        driverId:
                                            widget.driverId,
                                      );

                                      if (!mounted) return;

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DriverArrivingScreen(
                                            tripId:
                                                requests[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: OutlinedButton.icon(
                                    icon: const Icon(Icons.close),
                                    label: const Text("رفض"),

                                    onPressed: () async {
                                      await DriverService.instance
                                          .rejectTrip(
                                        requests[index].id,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}