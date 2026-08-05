import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/services/directions_service.dart';
import '../../../../core/services/google_places_service.dart';
import '../../../../core/services/location_service.dart';
import '../../../trip/data/trip_service.dart';
import '../../../notifications/data/notification_service.dart';
class MapController {
  MapController({
    required this.controller,
    required this.searchController,
  });

  final Completer<GoogleMapController> controller;
  final TextEditingController searchController;

  Timer? debounce;

  Position? currentPosition;
  LatLng? destination;

  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};

  List<Map<String, dynamic>> places = [];

  bool loading = false;

  String distance = "";
  String duration = "";

  /// نوع المركبة
  String vehicleType = "taxi";

  /// رقم الرحلة
  String? tripId;

  /// الاستماع لتحديثات الرحلة
  StreamSubscription? tripListener;

  /// موقع السائق
  LatLng? driverLocation;

  /// بيانات السائق
String driverName = "";
String driverPhone = "";
String driverCar = "";
String driverPlate = "";
double driverRate = 0;

/// حالة الرحلة
String tripStatus = "";

bool driverAccepted = false;
bool driverArrived = false;
bool tripStarted = false;
bool tripFinished = false;
bool tripCancelled = false;

  String get vehicleName =>
      vehicleType == "taxi"
          ? "تكسي"
          : "تكتك";

  bool get hasDestination =>
      destination != null;

  bool get hasActiveTrip =>
      tripId != null &&
      !tripFinished &&
      !tripCancelled;

  bool get canRequestTrip =>
      destination != null &&
      !hasActiveTrip;

  String get tripStatusText {
    switch (tripStatus) {
      case "pending":
        return "جاري البحث عن سائق";

      case "accepted":
        return "تم قبول الرحلة";

      case "arrived":
        return "السائق وصل";

      case "started":
        return "الرحلة جارية";

      case "completed":
        return "تم إنهاء الرحلة";

      case "cancelled":
        return "تم إلغاء الرحلة";

      default:
        return "";
    }
  }

  static const CameraPosition initialCamera =
      CameraPosition(
    target: LatLng(33.3152, 44.3661),
    zoom: 15,
  );

  Future<void> loadCurrentLocation(
    VoidCallback refresh,
  ) async {
    try {
      currentPosition =
          await LocationService.instance.determinePosition();

      final map = await controller.future;

      final me = LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      );

      markers.removeWhere(
        (e) => e.markerId.value == "me",
      );

      markers.add(
        Marker(
          markerId: const MarkerId("me"),
          position: me,
          infoWindow: const InfoWindow(
            title: "موقعي الحالي",
          ),
        ),
      );

      refresh();

      map.animateCamera(
        CameraUpdate.newLatLngZoom(
          me,
          17,
        ),
      );
    } catch (_) {}
  }
    Future<void> search(
    String text,
    VoidCallback refresh,
  ) async {
    debounce?.cancel();

    debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (text.trim().isEmpty) {
          places.clear();
          refresh();
          return;
        }

        loading = true;
        refresh();

        places = await GooglePlacesService.instance.searchPlaces(text);

        loading = false;
        refresh();
      },
    );
  }

  Future<void> selectPlace(
    Map<String, dynamic> place,
    VoidCallback refresh,
  ) async {
    final details =
        await GooglePlacesService.instance.getPlaceDetails(place);

    if (details == null) return;

    destination = LatLng(
      details["lat"],
      details["lng"],
    );

    markers.removeWhere(
      (e) => e.markerId.value == "destination",
    );

    markers.add(
      Marker(
        markerId: const MarkerId("destination"),
        position: destination!,
        infoWindow: InfoWindow(
          title: details["name"],
          snippet: details["address"],
        ),
      ),
    );

    searchController.text = details["name"];

    places.clear();

    await drawRoute(refresh);

    final map = await controller.future;

    await map.animateCamera(
      CameraUpdate.newLatLngZoom(
        destination!,
        16,
      ),
    );

    refresh();
  }

  Future<void> selectLocationFromMap(
    LatLng latLng,
    VoidCallback refresh,
  ) async {
    destination = latLng;

    markers.removeWhere(
      (m) => m.markerId.value == "destination",
    );

    markers.add(
      Marker(
        markerId: const MarkerId("destination"),
        position: latLng,
        infoWindow: const InfoWindow(
          title: "الوجهة",
        ),
      ),
    );

    final address =
        await GooglePlacesService.instance.reverseGeocode(
      latLng.latitude,
      latLng.longitude,
    );

    searchController.text =
        address ?? "الموقع المحدد";

    await drawRoute(refresh);

    final map = await controller.future;

    await map.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );

    refresh();
  }
Future<void> cancelTrip() async {
  if (tripId == null) return;

  await TripService.instance.cancelTrip(tripId!);

  tripListener?.cancel();

  clearTrip();

  tripId = null;

  tripStatus = "";
}
  Future<void> drawRoute(
    VoidCallback refresh,
  ) async {
    if (currentPosition == null ||
        destination == null) {
      return;
    }

    final route =
        await DirectionsService.instance.getDirections(
      origin: LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      ),
      destination: destination!,
    );

    if (route == null) return;

    distance = route["distanceText"];
    duration = route["durationText"];

    final points =
        DirectionsService.instance.decodePolyline(
      route["polyline"],
    );

    polylines.clear();

    polylines.add(
      Polyline(
        polylineId: const PolylineId("route"),
        points: points,
        width: 6,
        color: Colors.blue,
      ),
    );

    refresh();
  }

  String calculatePrice() {
    if (distance.isEmpty) {
      return "--";
    }

    double km = 1;

    if (distance.contains("km")) {
      km = double.tryParse(
            distance
                .replaceAll("km", "")
                .replaceAll(",", ".")
                .trim(),
          ) ??
          1;
    }

    final bool isTaxi =
        vehicleType == "taxi";

    const taxiStart = 2000.0;
    const taxiKm = 500.0;

    const tukStart = 1000.0;
    const tukKm = 300.0;

    final total = isTaxi
        ? taxiStart + (km * taxiKm)
        : tukStart + (km * tukKm);

    return "${total.toStringAsFixed(0)} د.ع";
  }
    Future<bool> requestTrip() async {
    if (currentPosition == null ||
        destination == null) {
      return false;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    final route =
        await DirectionsService.instance.getDirections(
      origin: LatLng(
        currentPosition!.latitude,
        currentPosition!.longitude,
      ),
      destination: destination!,
    );

    if (route == null) {
      return false;
    }

    final price = double.tryParse(
          calculatePrice()
              .replaceAll("د.ع", "")
              .trim(),
        ) ??
        0;

    final id =
        await TripService.instance.createTrip(
      customerId: user.uid,
      phone: user.phoneNumber ?? "",

      pickupLat: currentPosition!.latitude,
      pickupLng: currentPosition!.longitude,

      destinationLat: destination!.latitude,
      destinationLng: destination!.longitude,

      pickupAddress: "موقعي الحالي",
      destinationAddress:
          searchController.text,

      vehicleType: vehicleType,

      price: price,

      distance: route["distanceValue"],
      duration: route["durationValue"],
    );

    tripId = id;

    driverAccepted = false;
    driverArrived = false;
    tripStarted = false;
    tripFinished = false;
    tripCancelled = false;

    tripStatus = "pending";
await NotificationService.instance.sendNotification(
  userId: user.uid,
  title: "تم إرسال طلب الرحلة",
  body: "جارٍ البحث عن أقرب سائق إليك.",
  type: "trip",
  tripId: tripId,
);
    return true;
  }

  void changeVehicle(String value) {
    vehicleType = value;
  }

  void clearTrip() {
    destination = null;

    distance = "";
    duration = "";

    searchController.clear();

    polylines.clear();

    markers.removeWhere(
      (m) =>
          m.markerId.value ==
          "destination",
    );

    markers.removeWhere(
      (m) =>
          m.markerId.value ==
          "driver",
    );

    tripId = null;

    driverLocation = null;

    driverName = "";
    driverPhone = "";
    driverCar = "";
    driverPlate = "";
    driverRate = 0;

    driverAccepted = false;
    driverArrived = false;
    tripStarted = false;
    tripFinished = false;
    tripCancelled = false;

    tripStatus = "";
  }

  Future<void> listenTrip(
    String id,
    VoidCallback refresh,
  ) async {
    tripId = id;

    tripListener?.cancel();

    tripListener = TripService.instance
        .tripStream(id)
        .listen((trip) async {
      if (!trip.exists) return;

      final data = trip.data();

      if (data == null) return;

      tripStatus =
          data["status"] ?? "";

      driverName =
          data["driverName"] ?? "";

      driverPhone =
          data["driverPhone"] ?? "";

      driverCar =
          data["driverCar"] ?? "";

      driverPlate =
          data["driverPlate"] ?? "";

      driverRate =
          (data["driverRate"] ?? 0)
              .toDouble();

      driverAccepted =
          tripStatus == "accepted";

      driverArrived =
          tripStatus == "arrived";

      tripStarted =
          tripStatus == "started";

      tripFinished =
          tripStatus == "completed";

      tripCancelled =
          tripStatus == "cancelled";

      final lat =
          (data["driverLat"] as num?)
              ?.toDouble();

      final lng =
          (data["driverLng"] as num?)
              ?.toDouble();
                    if (lat != null &&
          lng != null &&
          lat != 0 &&
          lng != 0) {
        driverLocation = LatLng(
          lat,
          lng,
        );

        markers.removeWhere(
          (m) =>
              m.markerId.value ==
              "driver",
        );

        markers.add(
          Marker(
            markerId:
                const MarkerId("driver"),
            position: driverLocation!,
            infoWindow: InfoWindow(
              title:
                  driverName.isEmpty
                      ? "السائق"
                      : driverName,
              snippet: driverCar,
            ),
          ),
        );

        if (currentPosition != null) {
          final route =
              await DirectionsService.instance
                  .getDirections(
            origin: driverLocation!,
            destination: LatLng(
              currentPosition!.latitude,
              currentPosition!.longitude,
            ),
          );

          if (route != null) {
            distance =
                route["distanceText"];

            duration =
                route["durationText"];

            final points =
                DirectionsService.instance
                    .decodePolyline(
              route["polyline"],
            );

            polylines.clear();

            polylines.add(
              Polyline(
                polylineId:
                    const PolylineId(
                  "driver_route",
                ),
                points: points,
                width: 6,
                color: Colors.blue,
              ),
            );
          }
        }
      }

      refresh();
    });
  }

  void dispose() {
    debounce?.cancel();
    tripListener?.cancel();
  }
}