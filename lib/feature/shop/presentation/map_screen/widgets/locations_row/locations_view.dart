import 'package:flutter/material.dart';



import '../../../../domain/entities/app_lat_long.dart';
import '../view_location/view_location.dart';
class LocationsRow extends StatelessWidget {
  const LocationsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ViewLocation(
                imgUrl: "assets/idea.png",
                title: "Idea",
                address: "Ташкент, Юнусабадский р-н, ул А. Темура, 43/2",
                appLatLong: AppLatLong(
                    lat: 41.318118727817414, long: 69.29323833747138),
                distance: "1.5 km",
                timeToArrive: "10 min"),
            ViewLocation(
                imgUrl: "assets/texnomart.png",
                title: "Texnomart",
                address: "Ташкент, Юнусабад 11",
                appLatLong: AppLatLong(
                    lat: 41.318118727817414, long: 69.29323833747138),
                distance: "2.3 km",
                timeToArrive: "28 min"),
          ],
        ),
      ),
    );
  }
}
