// lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:iman_invest/bloc/map_screen/map_bloc.dart';
import '../bloc/map_screen/event/event.dart';
import '../bloc/map_screen/state/state.dart';
import '../services/map_service.dart';
import '../widgets/map_screen_widgets/buttons/current_location_button.dart';
import '../widgets/map_screen_widgets/buttons/tune_button.dart';
import '../widgets/map_screen_widgets/locations_row/locations_view.dart';
import '../widgets/map_screen_widgets/overlays/animated_bottom_overlay.dart';
import 'package:iman_invest/widgets/map_screen_widgets/buttons/back_button.dart'
    as back_button;

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(MapService()),
      child: const MapView(),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Stack(
              children: [
                YandexMap(
                  logoAlignment: const MapAlignment(
                      horizontal: HorizontalAlignment.center,
                      vertical: VerticalAlignment.top),
                  mapType: MapType.vector,
                  mapObjects: state.placemarks,
                  onMapCreated: (controller) async {
                    context
                        .read<MapBloc>()
                        .mapService
                        .mapControllerCompleter
                        .complete(controller);
                    context.read<MapBloc>().add(InitializeMap(context));
                  },
                ),
                back_button.BackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const TuneButton(),
                const CurrentLocationButton(),
                const LocationsRow(),
                AnimatedBottomOverlay(isOverlayVisible: state.isOverlayVisible),
              ],
            ),
          ),
        );
      },
    );
  }
}

