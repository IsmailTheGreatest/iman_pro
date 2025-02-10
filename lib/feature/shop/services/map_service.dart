import 'dart:async';

import 'package:flutter/services.dart';
import 'package:iman_invest/core/utils/azimuth_calculate.dart';
import 'package:iman_invest/core/utils/get_geometry.dart';
import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/feature/shop/services/app_location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// MapService class
class MapService {
  /// MapService constructor
  final Completer<YandexMapController> mapControllerCompleter =
      Completer<YandexMapController>();

  /// Load map style
  Future<void> loadMapStyle(YandexMapController controller) async {
    final styleJson = await rootBundle.loadString('assets/map_style.json');

    await controller.setMapStyle(styleJson);
    await controller.setMaxZoom(zoom: 17);
    await controller.moveCamera(CameraUpdate.tiltTo(67.5));
  }

  /// Fetch current location
  Future<AppLatLong> fetchCurrentLocation() async {
    try {
      return await LocationService().getCurrentLocation();
    } on Exception catch (_) {
      return const TashkentLocation();
    }
  }

  /// Move to current location
  Future<void> moveToCurrentLocation(
    YandexMapController controller,
    AppLatLong userLocation,
    List<AppLatLong> merchantLocation,
  ) async {
    merchantLocation.add(userLocation);
    final geometry = getGeometry(merchantLocation);
    await controller.moveCamera(
      CameraUpdate.azimuthTo(
        calculateAzimuth(userLocation, merchantLocation.first),
      ),
    );

    await controller.moveCamera(
      animation: const MapAnimation(duration: 0.4),
      CameraUpdate.newGeometry(
        geometry,
      ),
    );
  }

  /// Create user location place mark
  PlacemarkMapObject createUserLocationPlacemark(AppLatLong location) {
    return PlacemarkMapObject(
      opacity: 0.9,
      mapId: const MapObjectId('user_location'),
      point: Point(latitude: location.lat, longitude: location.long),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/current.png'),
          scale: 0.5,
        ),
      ),
    );
  }

  /// Initialize placemarks
  Future<List<PlacemarkMapObject>> initializePlacemarks(
    List<Merchant> merchants, {
    required void Function(Merchant) onMerchantTap,
  }) async {
    final placemarks = merchants
        .map(
          (merchant) => PlacemarkMapObject(
            opacity: 0.8,
            mapId: MapObjectId(merchant.guid),
            text: PlacemarkText(
              text: merchant.name,
              style: const PlacemarkTextStyle(
                offset: 23,
                outlineColor: Color(0xFF000000),
                placement: TextStylePlacement.right,
                color: Color(0xFFFFFFFF),
              ),
            ),
            point: Point(
              latitude: merchant.address.latitude,
              longitude: merchant.address.longitude,
            ),
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                anchor: Offset.zero,
                zIndex: 1,
                image: BitmapDescriptor.fromAssetImage('assets/merchant.png'),
                scale: 0.5,
              ),
            ),
            onTap: (PlacemarkMapObject self, Point point) {
              onMerchantTap(merchant);
            },
          ),
        )
        .toList();

    return placemarks;
  }
}
