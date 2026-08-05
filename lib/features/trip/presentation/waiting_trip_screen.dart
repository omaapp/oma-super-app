import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../trip/data/trip_service.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_radius.dart';

import '../../../core/widgets/danger_button.dart';
import '../../../app/app_routes.dart';

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
    extends State<WaitingTripScreen>
    with SingleTickerProviderStateMixin {

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      listener;

  late AnimationController animation;

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

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
          AppRoutes.driverArriving,
          arguments: widget.tripId,
        );
      }
    });
  }


  @override
  void dispose() {

    listener?.cancel();

    animation.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);


    return Scaffold(

      backgroundColor:
          theme.scaffoldBackgroundColor,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),

          child: Column(

            children: [

              const Spacer(),


              AnimatedBuilder(

                animation: animation,

                builder: (_, child) {

                  return Transform.scale(

                    scale:
                        1 +
                        (animation.value * .08),

                    child: child,

                  );
                },


                child: Container(

                  width: 120,

                  height: 120,


                  decoration: BoxDecoration(

                    color:
                        AppColors.primary
                            .withOpacity(.12),

                    shape:
                        BoxShape.circle,

                  ),


                  child: const Icon(

                    Icons.local_taxi_rounded,

                    size: 60,

                    color:
                        AppColors.primary,

                  ),

                ),

              ),



              const SizedBox(height: 35),



              Text(

                "جاري البحث عن سائق",

                style:
                    AppTextStyles.titleLarge,

                textAlign:
                    TextAlign.center,

              ),



              const SizedBox(height: 12),



              Text(

                "نبحث عن أقرب سائق متاح بالقرب منك",

                style:
                    AppTextStyles.bodyMedium,

                textAlign:
                    TextAlign.center,

              ),



              const SizedBox(height: 30),



              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                      AppSpacing.md,
                    ),


                decoration: BoxDecoration(

                  color:
                      theme.cardColor,

                  borderRadius:
                      BorderRadius.circular(
                        AppRadius.large,
                      ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          Colors.black
                              .withOpacity(.06),

                      blurRadius: 18,

                      offset:
                          const Offset(0, 8),

                    ),

                  ],

                ),


                child: Column(

                  children: [


                    const Icon(

                      Icons.access_time_rounded,

                      color:
                          AppColors.primary,

                    ),


                    const SizedBox(height: 10),


                    Text(

                      "رقم الرحلة",

                      style:
                          AppTextStyles.caption,

                    ),


                    const SizedBox(height: 4),


                    Text(

                      widget.tripId,

                      style:
                          AppTextStyles.bodyLarge,

                      textAlign:
                          TextAlign.center,

                    ),

                  ],

                ),

              ),



              const Spacer(),



              DangerButton(

                text:
                    "إلغاء الطلب",

                icon:
                    Icons.close,

                onPressed:
                    widget.onCancel,

              ),

            ],

          ),

        ),

      ),

    );

  }
}
