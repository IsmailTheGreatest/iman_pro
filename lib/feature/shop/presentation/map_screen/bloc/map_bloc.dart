// lib/bloc/map_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/bloc/state.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:iman_invest/services/map_service.dart';
import 'event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapService mapService;

  MapBloc(this.mapService) : super(const MapState(placemarks: [], isOverlayVisible: false)) {
    on<InitializePlacemarks>((event, emit) {
      final updatedPlacemarks = List<PlacemarkMapObject>.from(state.placemarks)
        ..addAll(event.placemarks);
      emit(MapState(
          placemarks: updatedPlacemarks,
          isOverlayVisible: state.isOverlayVisible));
    });

    on<ToggleOverlayVisibility>((event, emit) {
      emit(MapState(
          placemarks: state.placemarks,
          isOverlayVisible: !state.isOverlayVisible));
    });

    on<UpdatePlacemarkIcon>((event, emit) {
      final updatedPlacemarks = state.placemarks.map((placemark) {
        if (placemark.mapId.value == event.mapObjectId) {
          return placemark.copyWith(
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(event.newIconPath),
              scale: 0.7,
            )),
          );
        }
        return placemark;
      }).toList();
      emit(MapState(
          placemarks: updatedPlacemarks,
          isOverlayVisible: state.isOverlayVisible));
    });
    on<GoToUserLocation>((event, emit) async {
      final controller = await mapService.mapControllerCompleter.future;
      final location = await mapService.fetchCurrentLocation();
      await mapService.moveToCurrentLocation(controller, location);
    });
    on<InitializeMap>((event, emit) async {
      final controller = await mapService.mapControllerCompleter.future;
      await mapService.loadMapStyle(controller);
      final location = await mapService.fetchCurrentLocation();
      await mapService.moveToCurrentLocation(controller, location);
      final userPlacemark = mapService.createUserLocationPlacemark(location);
      final placemarks = mapService.initializePlacemarks(
        onUpdateIcon: (mapObjectId, newIconPath) {
          add(UpdatePlacemarkIcon(mapObjectId, newIconPath));
        },
        onToggleOverlay: () {
          add(ToggleOverlayVisibility());
        },
      );
      emit(MapState(
          placemarks: [...placemarks, userPlacemark],
          isOverlayVisible: state.isOverlayVisible));
    });
  }
}