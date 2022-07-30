import 'dart:async';

import 'package:flutter/material.dart';
import 'package:take_taxi_driver/services/location.service.dart';
import 'package:take_taxi_driver/services/directions.service.dart';

import '../firebase/firebase.dart';
import '../supabase/user-location.dart';
import '../widgets/drawer.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

LocationService locationService = LocationService();

UserLocationService userLocationService = UserLocationService();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var firebase = FireBaseInstance();
  late Timer _timer;
  var selectedEmail = 'todas@gmail.com';

  LocationService _locationService = LocationService();

  late final MapController mapController;
  var markers = <Marker>[
    Marker(
      point: LatLng(locationService.currentLocation.latitude,
          locationService.currentLocation.longitude),
      builder: (ctx) => Image.asset(
        'assets/icon/taketaxi-icon-v3.png',
        height: 1.0,
        width: 1.0,
        fit: BoxFit.cover,
      ),
    ),
  ];

  var directions = <Polyline>[
    Polyline(points: [
      LatLng(14.839347, 120.288421),
      LatLng(14.839479, 120.28856),
      LatLng(14.839917, 120.288144),
      LatLng(14.840357, 120.287705),
      LatLng(14.840565, 120.287908),
    ], color: Colors.blue)
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
    this.fetchLocationInterval();
    addNewMarker();
  }

  dispose() {
    this._timer.cancel(); // you need this
    super.dispose();
  }

  void fetchLocationInterval() async {
    await _locationService.getCurrentLocation();
  }

  void fetchUserLocation(email) async {
    await userLocationService.getUserLocation(email);
  }

  addNewMarker() {
    this._timer = Timer.periodic(new Duration(milliseconds: 2500), (timer) {
      this.fetchLocationInterval();
      this.fetchUserLocation(this.selectedEmail);

      var x = locationService.currentLocation.latitude;
      var y = locationService.currentLocation.longitude;

      var userX = userLocationService.currentUser.latitude;
      var userY = userLocationService.currentUser.longitude;
      print(markers[0].builder);
      markers.clear();

      markers.add(Marker(
        point: LatLng(x, y),
        builder: (ctx) => Image.asset(
          'assets/icon/taketaxi-icon-v3.png',
          height: 1.0,
          width: 1.0,
          fit: BoxFit.cover,
        ),
      ));

      markers.add(Marker(
        point: LatLng(userX, userY),
        builder: (ctx) => Image.asset(
          'assets/icon/taketaxi-icon-v3.png',
          height: 1.0,
          width: 1.0,
          fit: BoxFit.cover,
        ),
      ));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: buildDrawer(context, '/home'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('This is a map that is showing (51.5, -0.9).'),
            ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                    center: LatLng(locationService.currentLocation.latitude,
                        locationService.currentLocation.longitude),
                    zoom: 18.0,
                    maxZoom: 18.0),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        // 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    tileProvider: const NonCachingNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers),
                  PolylineLayerOptions(
                    polylineCulling: false,
                    polylines: directions,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
