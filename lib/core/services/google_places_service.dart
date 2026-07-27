import 'dart:convert';

import 'package:http/http.dart' as http;

class GooglePlacesService {
  GooglePlacesService._();

  static final instance = GooglePlacesService._();

  Future<List<Map<String, dynamic>>> searchPlaces(
    String query,
  ) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final uri = Uri.parse(
      "https://nominatim.openstreetmap.org/search"
      "?q=${Uri.encodeComponent(query)}"
      "&format=json"
      "&limit=10"
      "&countrycodes=iq"
      "&addressdetails=1",
    );

    final response = await http.get(
      uri,
      headers: {
        "User-Agent": "TaxiApp/1.0",
      },
    );

    if (response.statusCode != 200) {
      return [];
    }

    final data = jsonDecode(response.body);

    final results = List<Map<String, dynamic>>.from(data);

saveResults(results);

return results;
  }

  Future<Map<String, dynamic>?> getPlaceDetails(
    Map<String, dynamic> place,
  ) async {
    return {
      "name": place["display_name"],
      "address": place["display_name"],
      "lat": double.parse(place["lat"]),
      "lng": double.parse(place["lon"]),
    };
  }

  Future<String?> reverseGeocode(
    double lat,
    double lng,
  ) async {
    final uri = Uri.parse(
      "https://nominatim.openstreetmap.org/reverse"
      "?lat=$lat"
      "&lon=$lng"
      "&format=json",
    );

    final response = await http.get(
      uri,
      headers: {
        "User-Agent": "TaxiApp/1.0",
      },
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);

    return data["display_name"];
  }
  /// آخر نتائج البحث
List<Map<String, dynamic>> _lastResults = [];

List<Map<String, dynamic>> get lastResults => _lastResults;

/// حفظ النتائج الأخيرة
void saveResults(List<Map<String, dynamic>> results) {
  _lastResults = results;
}

/// أماكن شائعة
Future<List<Map<String, dynamic>>> popularPlaces() async {
  return searchPlaces(
    "مول بغداد, مطار بغداد, كربلاء, النجف, البصرة",
  );
}

/// البحث السريع
Future<List<Map<String, dynamic>>> smartSearch(
  String query,
) async {
  final results = await searchPlaces(query);

  saveResults(results);

  return results;
}
}