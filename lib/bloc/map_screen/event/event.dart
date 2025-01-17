import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
class GoToUserLocation extends MapEvent {}

class InitializeMap extends MapEvent {
  final BuildContext context;

  InitializeMap(this.context);

  @override
  List<Object> get props => [context];
}