import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

///
class MapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

///
class SelectMerchant extends MapEvent {

  ///
  SelectMerchant(this.merchant);
  ///
  final Merchant merchant;

  @override
  List<Object> get props => [merchant];
}

///
class GoToUserLocation extends MapEvent {}

///
class InitializeMap extends MapEvent {

  ///
  InitializeMap(this.context, this.controller);
  ///
  final YandexMapController controller;
  ///
  final BuildContext context;

  @override
  List<Object> get props => [context];
}
