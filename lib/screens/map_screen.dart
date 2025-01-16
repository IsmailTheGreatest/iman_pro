import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../bloc/map_bloc.dart';
import '../models/app_lat_long.dart';
import '../services/app_location.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(),
      child: MapView(),
    );
  }
}

class MapView extends StatelessWidget {
  final mapControllerCompleter = Completer<YandexMapController>();
  final Map<String, bool> placemarkToggles = {};

  MapView({super.key});

  Future<void> _loadMapStyle(YandexMapController controller) async {
    final styleJson = await rootBundle.loadString('assets/map_style.json');
    controller.setMapStyle(styleJson);
  }

  Future<void> _moveToCurrentLocation(
      YandexMapController controller, AppLatLong appLatLong) async {
    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat + 0.005,
            longitude: appLatLong.long,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  Future<void> _fetchCurrentLocation(BuildContext context) async {
    AppLatLong location;
    const defLocation = TashkentLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    final controller = await mapControllerCompleter.future;
    _moveToCurrentLocation(controller, location);
    _addUserLocationPlacemark(context, location);
  }

  void _addUserLocationPlacemark(BuildContext context, AppLatLong location) {
    final userLocationPlacemark = PlacemarkMapObject(
      opacity: 0.9,
      mapId: const MapObjectId('user_location'),
      point: Point(latitude: location.lat, longitude: location.long),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage('assets/current.png'),
        scale: 0.5,
      )),
    );
    context.read<MapBloc>().add(InitializePlacemarks([userLocationPlacemark]));
  }

  void _initializePlacemarks(BuildContext context) {
    final placemarks = [
      PlacemarkMapObject(
        opacity: 0.8,
        mapId: const MapObjectId('idea'),
        point: const Point(
            latitude: 41.325118727817414, longitude: 69.29323833747138),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          zIndex: 1,
          image: BitmapDescriptor.fromAssetImage('assets/idea_unselected.png'),
          scale: 0.7,
        )),
      ),
      PlacemarkMapObject(
        opacity: 0.8,
        mapId: const MapObjectId('texnomart'),
        point: const Point(
            latitude: 41.322018727817414, longitude: 69.30084033747138),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/ccccc.png'),
          scale: 0.7,
        )),
      ),
    ];

    // Initialize toggle states
    placemarkToggles['idea'] = false;
    placemarkToggles['texnomart'] = false;

    // Add onTap callbacks
    placemarks[0] = placemarks[0].copyWith(
      onTap: (PlacemarkMapObject self, Point point) {
        final isSelected = placemarkToggles[self.mapId.value] ?? false;
        final newIconPath = isSelected
            ? 'assets/idea_unselected.png'
            : 'assets/idea_selected.png';
        context
            .read<MapBloc>()
            .add(UpdatePlacemarkIcon(self.mapId.value, newIconPath));
        placemarkToggles[self.mapId.value] = !isSelected;
        context.read<MapBloc>().add(ToggleOverlayVisibility());
      },
    );

    placemarks[1] = placemarks[1].copyWith(
      onTap: (PlacemarkMapObject self, Point point) {
        final isSelected = placemarkToggles[self.mapId.value] ?? false;
        final newIconPath =
            isSelected ? 'assets/ccccc.png' : 'assets/texnomart_selected.png';
        context
            .read<MapBloc>()
            .add(UpdatePlacemarkIcon(self.mapId.value, newIconPath));
        placemarkToggles[self.mapId.value] = !isSelected;
        context.read<MapBloc>().add(ToggleOverlayVisibility());
      },
    );

    context.read<MapBloc>().add(InitializePlacemarks(placemarks));
  }

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
                    mapControllerCompleter.complete(controller);
                    _initializePlacemarks(context);

                    _loadMapStyle(controller);
                    _fetchCurrentLocation(context);
                  },
                ),
                Positioned(
                    top: 53,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff040415).withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    )),
                Positioned(
                    top: 53,
                    right: 20,
                    child: GestureDetector(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff040415).withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.tune),
                      ),
                    )),
                Positioned(
                  bottom: 170,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _fetchCurrentLocation(context),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/location.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
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
                            address:
                                "Ташкент, Юнусабадский р-н, ул А. Темура, 43/2",
                            appLatLong: AppLatLong(
                                lat: 41.318118727817414,
                                long: 69.29323833747138),
                            distance: "1.5 km",
                            timeToArrive: "10 min"),
                        ViewLocation(
                            imgUrl: "assets/texnomart.png",
                            title: "Texnomart",
                            address: "Ташкент, Юнусабад 11",
                            appLatLong: AppLatLong(
                                lat: 41.318118727817414,
                                long: 69.29323833747138),
                            distance: "2.3 km",
                            timeToArrive: "28 min"),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: state.isOverlayVisible ? 0 : -350,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ViewLocation extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String distance;
  final String timeToArrive;
  final String address;
  final AppLatLong appLatLong;

  const ViewLocation(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.address,
      required this.appLatLong,
      required this.distance,
      required this.timeToArrive});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(15),
      width: width - 50,
      height: 149,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width - 172,
                      child: Text(
                        title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width - 173,
                      height: 38,
                      child: Text(
                        address,
                        style: const TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 13,
                          color: Color(0xff74747b),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              SmallContainer(
                  text: distance, icon: Icons.location_on, onTap: () {}),
              SmallContainer(
                  text: timeToArrive,
                  icon: Icons.directions_walk,
                  onTap: () {}),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Open details screen
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xff4059E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Подробнее',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SmallContainer extends StatelessWidget {
  const SmallContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xfff4f4f5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Transform.scale(scaleY: 0.9, child: Icon(icon, color: Colors.black)),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomDetailsOverlay extends StatelessWidget {
  final ViewLocation viewLocation;

  const BottomDetailsOverlay({super.key, required this.viewLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 330,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(viewLocation.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        viewLocation.title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      child: Text(
                        "Магазин электроники\n",
                        style: TextStyle(
                          overflow: TextOverflow.visible,
                          fontSize: 13,
                          color: Color(0xff74747b),
                        ),
                      ),
                    ),
                    const Text("Другие филиалы",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff4059E6),
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 10, right: 5),
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Color(0xfff4f4f5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xff4059E6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Divider(
            color: const Color(0xff040415).withOpacity(0.1),
            thickness: 1,
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF4F4F5),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(
                    viewLocation.address,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff040405),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF4F4F5),
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: const Text(
                    "+998 12 234 56 78, +998 12 234 56 90",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff62c994),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF4F4F5),
                  ),
                  child: const Icon(
                    Icons.access_time_filled_rounded,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: const Text(
                    "пн-пт 10:00-21:00, сб-вс 10:00-20:00",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff040405),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
