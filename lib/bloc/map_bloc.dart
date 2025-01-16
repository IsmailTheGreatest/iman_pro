import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:equatable/equatable.dart';

class MapState extends Equatable {
  final List<PlacemarkMapObject> placemarks;
  final bool isOverlayVisible;

  const MapState({required this.placemarks, required this.isOverlayVisible});

  @override
  List<Object> get props => [placemarks, isOverlayVisible];
}

class MapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitializePlacemarks extends MapEvent {
  final List<PlacemarkMapObject> placemarks;

  InitializePlacemarks(this.placemarks);

  @override
  List<Object> get props => [placemarks];
}

class ToggleOverlayVisibility extends MapEvent {}

class UpdatePlacemarkIcon extends MapEvent {
  final String mapObjectId;
  final String newIconPath;

  UpdatePlacemarkIcon(this.mapObjectId, this.newIconPath);

  @override
  List<Object> get props => [mapObjectId, newIconPath];
}

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState(placemarks: [], isOverlayVisible: false)) {
    on<InitializePlacemarks>((event, emit) {
      final updatedPlacemarks =List<PlacemarkMapObject>.from(state.placemarks)
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
  }
}
