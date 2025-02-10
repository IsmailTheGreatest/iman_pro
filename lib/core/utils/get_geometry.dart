
 import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
///
Geometry getGeometry(List<AppLatLong> merchantLocation){
  final  minLat = merchantLocation
      .map((merchant) => merchant.lat)
      .reduce((a, b) => a < b ? a : b);
  final  minLong = merchantLocation
      .map((merchant) => merchant.long)
      .reduce((a, b) => a < b ? a : b);
  final  maxLat = merchantLocation
      .map((merchant) => merchant.lat)
      .reduce((a, b) => a > b ? a : b);
  final  maxLong = merchantLocation
      .map((merchant) => merchant.long)
      .reduce((a, b) => a > b ? a : b);

  const  paddingFactor = 0.35;
  final  latDelta = (maxLat - minLat) * paddingFactor;
  final  lonDelta = (maxLong - minLong) * paddingFactor;
  final paddedMinLat = minLat - latDelta;
  final paddedMinLong = minLong - lonDelta;
  final paddedMaxLat = maxLat + latDelta;
  final paddedMaxLong = maxLong + lonDelta;

  final southWest = Point(
    latitude: paddedMinLat,
    longitude: paddedMinLong,
  );
  final northEast = Point(
    latitude: paddedMaxLat,
    longitude: paddedMaxLong ,
  );


  final boundingBox = BoundingBox(southWest: southWest, northEast: northEast);
  final geometry = Geometry.fromBoundingBox(boundingBox);
  return geometry;
}
