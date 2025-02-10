// Method to calculate the distance between two lat-long points
import 'dart:math';

import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';

double _calculateDistance(AppLatLong from, AppLatLong to) {
  const earthRadius = 6371.0; // Radius of the Earth in kilometers
  final dLat = _degreesToRadians(to.lat - from.lat);
  final dLon = _degreesToRadians(to.long - from.long);

  final a = pow(sin(dLat / 2), 2) +
      cos(_degreesToRadians(from.lat)) *
          cos(_degreesToRadians(to.lat)) *
          pow(sin(dLon / 2), 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c; // Distance in kilometers
}

// Method to convert degrees to radians
double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

/// Method to sort merchants by distance and update the distance field
List<Merchant> sortMerchantsByDistance(
  AppLatLong userLocation,
  List<Merchant> merchants, {
  bool? doNotSort,
}) {
  for (final merchant in merchants) {
    // Update the distance field for each merchant
    merchant.address.distance = _calculateDistance(
      userLocation,
      AppLatLong(
        lat: merchant.address.latitude,
        long: merchant.address.longitude,
      ),
    );
  }

  // Sort merchants by the updated distance field
  if (doNotSort != true) {
    merchants.sort((a, b) => a.address.distance.compareTo(b.address.distance));
  }

  return merchants;
}
