
import 'dart:math';

import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';
/// Calculate azimuth
double calculateAzimuth(AppLatLong start, AppLatLong end) {
  // Convert latitudes and longitudes from degrees to radians
  final startLatRad = start.lat * pi / 180;
  final startLonRad = start.long * pi / 180;
  final endLatRad = end.lat * pi / 180;
  final endLonRad = end.long * pi / 180;

  // Compute delta longitude
  final deltaLon = endLonRad - startLonRad;

  // Calculate azimuth
  final y = sin(deltaLon) * cos(endLatRad);
  final x = cos(startLatRad) * sin(endLatRad) -
      sin(startLatRad) * cos(endLatRad) * cos(deltaLon);

  final azimuthRad = atan2(y, x);

  // Convert radians to degrees and normalize to [0, 360)
  final azimuthDeg = (azimuthRad * 180 / pi + 360) % 360;
  return azimuthDeg;
}
