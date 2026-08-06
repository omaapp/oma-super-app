import 'dart:async';

import 'package:flutter/material.dart';

import 'driver_arriving_screen.dart';
import '../data/trip_service.dart';

class SearchingDriverScreen extends StatefulWidget {
  final String tripId;

  const SearchingDriverScreen({
    super.key,
    required this.tripId,
  });

  @override
  State<SearchingDriverScreen> createState() =>
      _SearchingDriverScreenState();
}

class _SearchingDriverScreenState
    extends State<SearchingDriverScreen>
    with TickerProviderStateMixin {

  late AnimationController pulseController;

  late Animation<double> scaleAnimation;

  StreamSubscription? subscription;

  String status = "pending";

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    scaleAnimation = Tween(
      begin: .9,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: pulseController,
        curve: Curves.easeInOut,
      ),
    );

    pulseController.repeat(reverse: true);

    listenTrip();
  }

  void listenTrip() {
    subscription = TripService.instance
        .tripStream(widget.tripId)
        .listen((trip) {
      if (!trip.exists) return;

      final data = trip.data();

      if (data == null) return;

      status = data["status"] ?? "pending";

      if (!mounted) return;

      setState(() {});

      if (status == "accepted") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DriverArrivingScreen(
              tripId: widget.tripId,
            ),
          ),
        );
      }

      if (status == "cancelled") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "تم إلغاء الرحلة",
            ),
          ),
        );

        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    pulseController.dispose();
    subscription?.cancel();
    super.dispose();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1565C0),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Spacer(),

              ScaleTransition(
                scale: scaleAnimation,

                child: Container(
                  width: 170,
                  height: 170,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: .30),
                        blurRadius: 40,
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.local_taxi,
                    size: 90,
                    color: Color(0xff1565C0),
                  ),
                ),
              ),

              const SizedBox(height: 45),

              const Text(
                "جاري البحث عن سائق",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "يرجى الانتظار...\nسيتم إشعارك فور قبول أحد السائقين للرحلة.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 40),

              const CircularProgressIndicator(
                color: Colors.white,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 56,

                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: () async {

                    await TripService.instance
                        .cancelTrip(
                      widget.tripId,
                    );

                    if (!mounted) return;

                    Navigator.pop(context);
                  },

                  child: const Text(
                    "إلغاء الطلب",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}