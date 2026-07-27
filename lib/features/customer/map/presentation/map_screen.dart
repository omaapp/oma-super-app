import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class _MapScreenState extends State<MapScreen> {
  late final MapController map;

  final Completer<GoogleMapController> _googleController =
      Completer<GoogleMapController>();

  final TextEditingController _searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    map = MapController(
      controller: _googleController,
      searchController: _searchController,
    );

    map.changeVehicle(widget.initialVehicle);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      map.loadCurrentLocation(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
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

    return Scaffold(
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

          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: SearchBox(
                controller: _searchController,

                loading: map.loading,

                onChanged: (text) {
                  map.search(text, _refresh);
                },

                placesList: map.places.isEmpty
                    ? null
                    : Container(
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius:
                              BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 220,
                          child: ListView.builder(
                            itemCount: map.places.length,
                            itemBuilder: (context, index) {
                              final place =
                                  map.places[index];

                              return ListTile(
                                leading: const Icon(
                                  Icons.location_on,
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

          Positioned(
            right: 16,
            bottom: 280,
            child: MapFab(
              onPressed: () async {
                await map.loadCurrentLocation(
                  _refresh,
                );
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
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
    builder: (_) => WaitingTripScreen(
      tripId: map.tripId!,
      onCancel: () async {
        if (map.tripId != null) {
          await map.cancelTrip();
        }

        Navigator.pop(context);
      },
    ),
  ),
);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "تعذر إرسال الطلب",
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}