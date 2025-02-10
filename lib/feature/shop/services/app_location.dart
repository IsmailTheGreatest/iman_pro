import 'package:geolocator/geolocator.dart';

import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';

///
abstract class AppLocation {
  /// Get current location
  Future<AppLatLong> getCurrentLocation();

  /// Request permission
  Future<bool> requestPermission();

  /// Check permission
  Future<bool> checkPermission();
}

/// LocationService class
class LocationService implements AppLocation {
  /// LocationService constructor
  final defLocation = const TashkentLocation();

  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then(
          (value) =>
              value == LocationPermission.always ||
              value == LocationPermission.whileInUse,
        )
        .catchError((_) => false);
  }

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then(
          (value) =>
              value == LocationPermission.always ||
              value == LocationPermission.whileInUse,
        )
        .catchError((_) => false);
  }
}
