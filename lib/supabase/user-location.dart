import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:take_taxi_driver/models/location.dart';
import 'package:take_taxi_driver/models/location_data.dart';
import 'package:take_taxi_driver/pages/home.dart';
import 'package:take_taxi_driver/services/auth.service.dart';
import 'package:take_taxi_driver/supabase/auth-supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_taxi_driver/services/auth.service.dart';

final supabase = SupabaseAuthService();
final supabaseClient = Supabase.instance.client;
AuthService authService = AuthService();

class UserLocationService {
  static final UserLocationService _instance = UserLocationService._internal();

  // passes the instantiation to the _instance object
  factory UserLocationService() {
    return _instance;
  }

  //initialize variables in here
  UserLocationService._internal() {}

  late LocationData _currentUser;

  LocationData get currentUser => _currentUser;

  set currentUser(LocationData value) => currentUser = value;

  void setUser(LocationData value) {
    print(value);
    _currentUser = value;
  }

  getUserLocation(email) async {
    try {
      final res = await supabaseClient
          .from('user_location')
          .select('*')
          .eq('email', email)
          .single()
          .execute();

      final error = res.error;
      if (error != null && res.status != 406) {
        print(error.message);
      } else {
        print(res.data);
      }
      final data = res.data;

      LocationData userData =
          LocationData(data['lat'], data['lon'], data['email']);
      this.setUser(userData);
      print(res);
    } catch (e) {
      print(e);
    }
  }
}
