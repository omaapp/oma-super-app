import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService._();

  static final instance = LocationService._();

  Future<Position> determinePosition() async {
    bool serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("خدمة الموقع غير مفعلة");
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception("تم رفض إذن الموقع");
    }

    if (permission ==
        LocationPermission.deniedForever) {
      throw Exception("تم رفض إذن الموقع نهائياً");
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  /// تحديث مباشر للموقع
  Stream<Position> positionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    );
  }

  /// آخر موقع معروف
  Future<Position?> lastKnownLocation() {
    return Geolocator.getLastKnownPosition();
  }

  /// فتح إعدادات GPS
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  /// فتح إعدادات الصلاحيات
  Future<bool> openPermissionSettings() {
    return Geolocator.openAppSettings();
  }

  /// هل الـ GPS يعمل؟
  Future<bool> isServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }
}
