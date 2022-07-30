// ignore_for_file: unused_element

import 'package:geolocator/geolocator.dart';
import 'package:take_taxi_driver/models/location.dart';
import 'package:take_taxi_driver/supabase/auth-supabase.dart';
import 'package:take_taxi_driver/supabase/driver-location.dart';

SupabaseAuthService supabaseAuthService = SupabaseAuthService();
DriverLocationService driverLocationService = DriverLocationService();

class LocationService {
  static final LocationService _instance = LocationService._internal();

  // passes the instantiation to the _instance object
  factory LocationService() {
    return _instance;
  }

  //initialize variables in here
  LocationService._internal() {}

  Location _currentLocation = Location(0, 0);

  Location get currentLocation => _currentLocation;

  set currentLocation(Object value) => currentLocation = value;

  void setCurrentLocation(value) {
    _currentLocation = Location(value.latitude, value.longitude);
  }

  getCurrentLocation() async {
    var getLoc = await _determinePosition();
    setCurrentLocation(getLoc);
    driverLocationService.updateDriverLocation(_currentLocation);
    print(getLoc);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      permission = await Geolocator.requestPermission();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }
}
