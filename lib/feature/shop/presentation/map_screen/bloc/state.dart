
import 'package:equatable/equatable.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapState extends Equatable {
  final List<PlacemarkMapObject> placemarks;
  final bool isOverlayVisible;

  const MapState({required this.placemarks, required this.isOverlayVisible});

  @override
  List<Object> get props => [placemarks, isOverlayVisible];
}
