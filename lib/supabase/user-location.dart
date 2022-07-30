import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_taxi/models/location.dart';
import 'package:pocket_taxi/models/location_data.dart';
import 'package:pocket_taxi/pages/home.dart';
import 'package:pocket_taxi/services/auth.service.dart';
import 'package:pocket_taxi/supabase/auth-supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocket_taxi/services/auth.service.dart';

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
