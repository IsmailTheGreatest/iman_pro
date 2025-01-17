import 'package:flutter/material.dart';
import 'package:iman_invest/widgets/map_screen_widgets/overlays/bottom_overlay.dart';

import '../../../models/app_lat_long.dart';
import '../view_location/view_location.dart';
class AnimatedBottomOverlay extends StatelessWidget{
  final bool isOverlayVisible;
  const AnimatedBottomOverlay({
    super.key, required this.isOverlayVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: isOverlayVisible ? 0 : -350,
      left: 0,
      curve: Curves.easeInToLinear,
      right: 0,
      child: const BottomDetailsOverlay(
        viewLocation: ViewLocation(
          imgUrl: "assets/idea.png",
          title: "Idea",
          address: "Ташкент, Юнусабадский р-н, ул А. Темура, 43/2",
          appLatLong: AppLatLong(
              lat: 41.318118727817414, long: 69.29323833747138),
          distance: "1.5 km",
          timeToArrive: "10 min",
        ),
      ),
    );
  }
}


