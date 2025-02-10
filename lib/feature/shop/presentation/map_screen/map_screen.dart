// lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/bloc/event.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/bloc/map_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/bloc/state.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/widgets/buttons/back_button.dart'
    as back_button;
import 'package:iman_invest/feature/shop/presentation/map_screen/widgets/buttons/current_location_button.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/widgets/buttons/tune_button.dart';
import 'package:iman_invest/feature/shop/presentation/map_screen/widgets/locations_row/locations_view.dart';
import 'package:iman_invest/feature/shop/services/map_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// MapScreen class
class MapScreen extends StatelessWidget {
  /// MapScreen constructor
  const MapScreen({required this.merchants, super.key});

  /// MapScreen constructor
  final List<Merchant> merchants;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(MapService(), merchants),
      child: MapView(merchants: merchants),
    );
  }
}

/// MapView class
class MapView extends StatelessWidget {
  /// MapView constructor
  const MapView({required this.merchants, super.key});

  /// MapView constructor
  final List<Merchant> merchants;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Stack(
              children: [
                BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    return YandexMap(
                      logoAlignment: const MapAlignment(
                        horizontal: HorizontalAlignment.left,
                        vertical: VerticalAlignment.top,
                      ),
                      mapObjects: state.placemarks,
                      onMapCreated: (controller) async {
                        context
                            .read<MapBloc>()
                            .add(InitializeMap(context, controller));
                      },
                    );
                  },
                ),
                back_button.BackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const TuneButton(),
                const CurrentLocationButton(),
                LocationsRow(merchants: merchants),
              ],
            ),
          ),
        );
      },
    );
  }
}
