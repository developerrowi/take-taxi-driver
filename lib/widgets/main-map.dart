import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:take_taxi_driver/services/location.service.dart';
import 'package:take_taxi_driver/services/directions.service.dart';

import '../supabase/user-location.dart';
import '../widgets/drawer.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

late Timer _timer;

LocationService locationService = LocationService();
UserLocationService userLocationService = UserLocationService();

class MainMap {
  static Widget mainMap(markers, directions, mapControl) {
    return InkWell(
      child: FlutterMap(
        mapController: mapControl,
        options: MapOptions(
            center: LatLng(locationService.currentLocation.latitude,
                locationService.currentLocation.longitude),
            zoom: 17.0,
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
    );
  }
}
