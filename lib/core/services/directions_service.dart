import 'dart:convert';
import 'dart:math' as math;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
class DirectionsService {
  DirectionsService._();

  static final instance = DirectionsService._();

  Future<Map<String, dynamic>?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/"
      "${origin.longitude},${origin.latitude};"
      "${destination.longitude},${destination.latitude}"
      "?overview=full"
      "&geometries=polyline"
      "&steps=false",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return null;
      }

      final data = jsonDecode(response.body);

      if (data["code"] != "Ok") {
        return null;
      }

      final route = data["routes"][0];

      final distanceMeters =
          (route["distance"] as num).toDouble();

      final durationSeconds =
          (route["duration"] as num).toDouble();

      return {
        "distanceText":
            _formatDistance(distanceMeters),

        "distanceValue":
            distanceMeters.round(),

        "durationText":
            _formatDuration(durationSeconds),

        "durationValue":
            durationSeconds.round(),

        "polyline":
            route["geometry"],
      };
    } catch (_) {
      return null;
    }
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return "${(meters / 1000).toStringAsFixed(1)} كم";
    }

    return "${meters.round()} متر";
  }

  String _formatDuration(double seconds) {
    final minutes = (seconds / 60).round();

    if (minutes < 60) {
      return "$minutes دقيقة";
    }

    final hours = minutes ~/ 60;
    final remain = minutes % 60;

    return "$hours ساعة $remain دقيقة";
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polylineCoordinates = [];

    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < encoded.length) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      lat += (result & 1) != 0
          ? ~(result >> 1)
          : (result >> 1);

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      lng += (result & 1) != 0
          ? ~(result >> 1)
          : (result >> 1);

      polylineCoordinates.add(
        LatLng(
          lat / 1E5,
          lng / 1E5,
        ),
      );
    }

    return polylineCoordinates;
  }
  /// سرعة تقريبية حسب نوع المركبة
double averageSpeed(String vehicleType) {
  switch (vehicleType) {
    case "tuk":
      return 28;
    default:
      return 45;
  }
}

/// حساب وقت الوصول التقريبي
String estimateArrival({
  required double distanceKm,
  required String vehicleType,
}) {
  final speed = averageSpeed(vehicleType);

  final minutes = ((distanceKm / speed) * 60).round();

  if (minutes < 60) {
    return "$minutes دقيقة";
  }

  final h = minutes ~/ 60;
  final m = minutes % 60;

  return "$h ساعة $m دقيقة";
}

/// حساب المسافة بين نقطتين
double calculateDistanceKm(
  LatLng start,
  LatLng end,
) {
  const earth = 6371.0;

  final dLat = (end.latitude - start.latitude) * 0.0174532925;
  final dLng = (end.longitude - start.longitude) * 0.0174532925;

  final a =
      (dLat / 2).sin() * (dLat / 2).sin() +
      start.latitude *
          0.0174532925
          .cos() *
          end.latitude
              .toRad()
              .cos() *
          (dLng / 2).sin() *
          (dLng / 2).sin();

  final c =
      2 *
      math.atan2(
        math.sqrt(a),
        math.sqrt(1 - a),
      );

  return earth * c;
}
}


extension DegreeExtension on num {
  double toRad() => this * pi / 180;
}

extension SinCos on double {
  double sin() => math.sin(this);
  double cos() => math.cos(this);
}