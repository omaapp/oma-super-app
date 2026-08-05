import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_scaffold.dart';

import '../../home/presentation/widgets/animated_appear.dart';

import '../controllers/map_controller.dart';

import 'widgets/map_fab.dart';
import 'widgets/search_box.dart';
import 'widgets/trip_info_card.dart';

import '../../../trip/presentation/waiting_trip_screen.dart';

class MapScreen extends StatefulWidget {
  final String initialVehicle;

  const MapScreen({
    super.key,
    this.initialVehicle = "taxi",
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with TickerProviderStateMixin {
  late final MapController map;

  final Completer<GoogleMapController> _googleController =
      Completer<GoogleMapController>();

  final TextEditingController _searchController =
      TextEditingController();

  late final AnimationController pageAnimation;

  @override
  void initState() {
    super.initState();

    pageAnimation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );

    pageAnimation.forward();

    map = MapController(
      controller: _googleController,
      searchController: _searchController,
    );

    map.changeVehicle(widget.initialVehicle);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      map.loadCurrentLocation(() {
        if (!mounted) return;

        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    pageAnimation.dispose();
    map.dispose();
    super.dispose();
  }

  void _refresh() {
    if (!mounted) return;

    setState(() {});
  }
    @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                MapController.initialCamera,

            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,

            markers: map.markers,
            polylines: map.polylines,

            onTap: (LatLng latLng) async {
              await map.selectLocationFromMap(
                latLng,
                _refresh,
              );
            },

            onMapCreated: (controller) {
              if (!_googleController.isCompleted) {
                _googleController.complete(controller);
              }
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                AppSpacing.md,
              ),
              child: AnimatedAppear(
                delay: const Duration(
                  milliseconds: 120,
                ),
                child: SearchBox(
                  controller: _searchController,
                  loading: map.loading,

                  onChanged: (text) {
                    map.search(
                      text,
                      _refresh,
                    );
                  },

                  placesList:
                      map.places.isEmpty
                          ? null
                          : Material(
                              elevation: 18,
                              color: theme.cardColor,
                              borderRadius:
                                  BorderRadius.circular(
                                AppRadius.large,
                              ),
                              child: SizedBox(
                                height: 240,
                                child: ListView.builder(
                                  itemCount:
                                      map.places.length,

                                  itemBuilder:
                                      (
                                        context,
                                        index,
                                      ) {
                                        final place =
                                            map.places[index];

                                        return ListTile(
                                          leading:
                                              CircleAvatar(
                                            backgroundColor:
                                                AppColors.primary
                                                    .withValues(
                                              alpha: .10,
                                            ),
                                            child: const Icon(
                                              Icons.location_on,
                                              color: AppColors
                                                  .primary,
                                            ),
                                          ),

                                          title: Text(
                                            place["display_name"],
                                            maxLines: 1,
                                            overflow:
                                                TextOverflow
                                                    .ellipsis,
                                          ),

                                          subtitle: Text(
                                            "${place["lat"]}, ${place["lon"]}",
                                          ),

                                          onTap: () async {
                                            await map.selectPlace(
                                              place,
                                              _refresh,
                                            );
                                          },
                                        );
                                      },
                                ),
                              ),
                            ),
                ),
              ),
            ),
          ),

          Positioned(
            right: AppSpacing.md,
            bottom: 300,
            child: Column(
              children: [
                AnimatedAppear(
                  delay: const Duration(
                    milliseconds: 300,
                  ),
                  child: Material(
                    elevation: 10,
                    color: theme.cardColor,
                    borderRadius:
                        BorderRadius.circular(
                      AppRadius.large,
                    ),
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(
                        AppRadius.large,
                      ),
                      onTap: () async {
                        await map.loadCurrentLocation(
                          _refresh,
                        );
                      },
                      child: SizedBox(
                        width: 58,
                        height: 58,
                        child: Icon(
                          Icons.my_location,
                          color:
                              theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                AnimatedAppear(
                  delay: const Duration(
                    milliseconds: 420,
                  ),
                  child: MapFab(
                    onPressed: () async {
                      await map.loadCurrentLocation(
                        _refresh,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
                    Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSlide(
              duration: const Duration(
                milliseconds: 350,
              ),
              offset: const Offset(0, 0),
              curve: Curves.easeOutCubic,
              child: AnimatedAppear(
                delay: const Duration(
                  milliseconds: 520,
                ),
                child: TripInfoCard(
                  hasDestination:
                      map.destination != null,

                  vehicleType:
                      map.vehicleType,

                  onVehicleChanged: (value) {
                    setState(() {
                      map.changeVehicle(value);
                    });
                  },

                  distance: map.distance,
                  duration: map.duration,
                  price: map.calculatePrice(),

                  tripStatus: map.tripStatus,

                  driverName: map.driverName,
                  driverCar: map.driverCar,
                  driverPhone: map.driverPhone,

                  onRequestTrip: () async {
                    final ok =
                        await map.requestTrip();

                    if (!mounted) return;

                    if (ok) {
                      if (map.tripId != null) {
                        map.listenTrip(
                          map.tripId!,
                          _refresh,
                        );
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              WaitingTripScreen(
                            tripId: map.tripId!,
                            onCancel: () async {
                              if (map.tripId != null) {
                                await map.cancelTrip();
                              }

                              if (!mounted) return;

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          backgroundColor:
                              AppColors.error,
                          content: const Text(
                            "تعذر إرسال الطلب",
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
