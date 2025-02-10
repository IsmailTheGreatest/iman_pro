
import 'package:equatable/equatable.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


///
class MapState extends Equatable {


  ///
  const MapState( {required this.placemarks,});
  ///
  final List<PlacemarkMapObject> placemarks;

  @override
  List<Object> get props => [placemarks];
}
