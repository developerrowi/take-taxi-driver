import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:take_taxi_driver/models/location.dart';
import 'package:take_taxi_driver/pages/home.dart';
import 'package:take_taxi_driver/services/auth.service.dart';
import 'package:take_taxi_driver/supabase/auth-supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_taxi_driver/services/auth.service.dart';

import '../models/driver.dart';

final supabase = SupabaseAuthService();
final supabaseClient = Supabase.instance.client;
AuthService authService = AuthService();

class DriverLocationService {
  static final DriverLocationService _instance =
      DriverLocationService._internal();

  // passes the instantiation to the _instance object
  factory DriverLocationService() {
    return _instance;
  }

  //initialize variables in here
  DriverLocationService._internal() {}

  updateDriverLocation(Location currentLocation) async {
    try {
      final email = supabase.currentUser.Email;

      print(email);

      final data = {
        'email': email,
        'lat': currentLocation.latitude,
        'lon': currentLocation.longitude
      };

      final res = await supabaseClient
          .from('driver_location')
          .update(data)
          .match({'email': email}).execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      print(res);
    } catch (e) {
      print(e);
    }
  }

  saveDriverLocation(email) async {
    try {
      final currentLocation = locationService.currentLocation;

      print(email);

      final data = {
        'email': email,
        'lat': currentLocation.latitude,
        'lon': currentLocation.longitude
      };

      final res =
          await supabaseClient.from('driver_location').insert(data).execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      print(res);
    } catch (e) {
      print(e);
    }
  }
}
