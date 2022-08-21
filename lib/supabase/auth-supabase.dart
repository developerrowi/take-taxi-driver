import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:take_taxi_driver/services/auth.service.dart';
import 'package:take_taxi_driver/supabase/driver-location.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:take_taxi_driver/services/auth.service.dart';

import '../models/driver.dart';

var supabase = Supabase.instance.client;
DriverLocationService driverLocationService = DriverLocationService();
AuthService authService = AuthService();

class SupabaseAuthService {
  static final SupabaseAuthService _instance = SupabaseAuthService._internal();

  // passes the instantiation to the _instance object
  factory SupabaseAuthService() {
    return _instance;
  }

  //initialize variables in here
  SupabaseAuthService._internal() {}

  Driver _currentUser = Driver(
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  );

  Driver get currentUser => _currentUser;

  set currentUser(Object value) => currentUser = value;

  void setUser(Driver value) {
    print(value);
    _currentUser = value;
  }

  void initializeSupabase() async {
    final subscription = supabase.auth.onAuthStateChange((event, session) {
      if (session == null) {
        print('User is currently signed out!');
        authService.setIsLoggedIn(false);
      } else {
        print('User is signed in!');
        authService.setIsLoggedIn(true);
      }
      print(session);
      // handle auth state change
    });

    this.logoutSupabase();
  }

  emailSignInToSupabase(String email, String password) async {
    try {
      print(email);
      print(password);
      final res = await supabase.auth.signIn(email: email, password: password);

      final user = res.data?.user;

      final currentUser = supabase.auth.user();

      final driverDetails = await supabase
          .from('driver_details')
          .select('*')
          .eq('email', email)
          .single()
          .execute();
      final error = driverDetails.error;
      if (error != null && driverDetails.status != 406) {
        print(error.message);
      } else {
        print(driverDetails.data);
      }
      final data = driverDetails.data;

      print('This is all users email' + data['email']);
      ;

      print(data['id'] +
          email +
          data['license_number'] +
          data['first_name'] +
          data['last_name'] +
          '');
      final currentDriver = Driver(data['id'], email, '',
          data['license_number'], data['first_name'], data['last_name'], '');
      this.setUser(currentDriver);
      print(currentUser);
    } catch (e) {}
  }

  emailRegisterToSupabase(
      String email,
      String password,
      String firstName,
      String lastName,
      String phoneNumber,
      String licenseNumber,
      String bodyNumber,
      int seater) async {
    try {
      final res = await supabase.auth.signUp(email, password);
      final updates = {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'license_number': licenseNumber,
        'phone_number': phoneNumber,
        'body_number': bodyNumber,
        'seater': seater
      };

      final driverDetails =
          await supabase.from('driver_details').insert(updates).execute();

      driverLocationService.saveDriverLocation(email);

      final error = driverDetails.error;
      if (error != null) {
        print(error.message);
      } else {
        print('Successfully Registered!');

        Driver currentDriver = Driver(
            '', email, phoneNumber, licenseNumber, firstName, lastName, '');

        this.setUser(currentDriver);
      }
      print(driverDetails);

      // final user = res.data?.user;
      // final error = res.error;
    } catch (e) {
      print(e);
    }
  }

  logoutSupabase() async {
    try {
      authService.setIsLoggedIn(false);
      await supabase.auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
