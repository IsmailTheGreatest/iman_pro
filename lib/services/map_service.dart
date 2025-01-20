// lib/services/map_service.dart
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../feature/shop/domain/entities/app_lat_long.dart';
import '../services/app_location.dart';

class MapService {
  final Completer<YandexMapController> mapControllerCompleter =
      Completer<YandexMapController>();
  final Map<String, bool> placemarkToggles = {};

  Future<void> loadMapStyle(YandexMapController controller) async {
    final styleJson = await rootBundle.loadString('assets/map_style.json');
    controller.setMapStyle(styleJson);
  }

  Future<AppLatLong> fetchCurrentLocation() async {
    try {
      return await LocationService().getCurrentLocation();
    } catch (_) {
      return const TashkentLocation();
    }
  }

  Future<void> moveToCurrentLocation(
      YandexMapController controller, AppLatLong appLatLong) async {
    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat + 0.005,
            longitude: appLatLong.long,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  PlacemarkMapObject createUserLocationPlacemark(AppLatLong location) {
    return PlacemarkMapObject(
      opacity: 0.9,
      mapId: const MapObjectId('user_location'),
      point: Point(latitude: location.lat, longitude: location.long),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage('assets/current.png'),
        scale: 0.5,
      )),
    );
  }

  List<PlacemarkMapObject> initializePlacemarks({
    required void Function(String mapObjectId, String newIconPath) onUpdateIcon,
    required void Function() onToggleOverlay,
  }) {
    final placemarks = [
      PlacemarkMapObject(
        opacity: 0.8,
        mapId: const MapObjectId('idea'),
        point: const Point(
            latitude: 41.325118727817414, longitude: 69.29323833747138),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          zIndex: 1,
          scale: 0.7,
          image: BitmapDescriptor.fromAssetImage('assets/idea_unselected.png'),
        )),
        onTap: (PlacemarkMapObject self, Point point) {
          final isSelected = placemarkToggles[self.mapId.value] ?? false;
          final newIconPath = isSelected
              ? 'assets/idea_unselected.png'
              : 'assets/idea_selected.png';
          onUpdateIcon(self.mapId.value, newIconPath);
          placemarkToggles[self.mapId.value] = !isSelected;
          onToggleOverlay();
        },
      ),
      PlacemarkMapObject(
        opacity: 0.8,
        mapId: const MapObjectId('texnomart'),
        point: const Point(
            latitude: 41.322018727817414, longitude: 69.30084033747138),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
              'assets/texnomart_unselected.png'),
          scale: 0.7,
        )),
        onTap: (PlacemarkMapObject self, Point point) {
          final isSelected = placemarkToggles[self.mapId.value] ?? false;
          final newIconPath = isSelected
              ? 'assets/texnomart_unselected.png'
              : 'assets/texnomart_selected.png';
          onUpdateIcon(self.mapId.value, newIconPath);
          placemarkToggles[self.mapId.value] = !isSelected;
          onToggleOverlay();
        },
      ),
    ];

    // Initialize toggle states
    placemarkToggles['idea'] = false;
    placemarkToggles['texnomart'] = false;

    return placemarks;
  }
}
