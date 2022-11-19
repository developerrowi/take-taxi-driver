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

class BookingService {
  static final BookingService _instance = BookingService._internal();

  // passes the instantiation to the _instance object
  factory BookingService() {
    return _instance;
  }

  //initialize variables in here
  BookingService._internal() {}

  getBookings() async {
    try {
      final res = await supabaseClient.from('bookings').select('*').execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      return res.data;
    } catch (e) {
      print(e);
    }
  }

  createBooking(passenger_email, destination, lat_destination, lon_destination,
      lat_pickup, lon_pickup, first_name, last_name, nickname) async {
    try {
      final updates = {
        'passenger_email': passenger_email,
        // 'destination': destination,
        'destination': 'baretto',
        'lat_destination': lat_destination,
        'lon_destination': lon_destination,
        'lat_pickup': lat_pickup,
        'lon_pickup': lon_pickup,
        'first_name': first_name,
        'last_name': last_name,
        'nickname': nickname,
      };

      final res = await supabaseClient.from('offers').insert(updates).execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      print("this is offer");
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
    }
  }

  createOffer(booking_id, fare) async {
    try {
      final updates = {
        'driver_id': supabase.currentUser.driver_id,
        'booking_id': booking_id,
        'fare': fare,
      };

      final res = await supabaseClient.from('offers').insert(updates).execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      print("this is offer");
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
    }
  }

  getOffersByDriver() async {
    try {
      final res = await supabaseClient
          .from('offers')
          .select("*," + "bookings(*)")
          .eq('driver_id', supabase.currentUser.driver_id)
          .execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      print(supabase.currentUser);
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
    }
  }

  getCurrentBookingByClient() async {
    try {
      final res = await supabaseClient
          .from('offers')
          .select("*," + "driver_details(id)")
          .eq('passenger_email', supabase.currentUser.Email)
          .eq('is_current', true)
          .execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      print("this is current booking of client");
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
    }
  }

  getOffersByBookingID(booking_id) async {
    try {
      final res = await supabaseClient
          .from('offers')
          .select("*," + "driver_details(id)")
          .eq('booking_id', booking_id)
          .execute();

      final error = res.error;
      if (error != null) {
        print(error.message);
      } else {}
      print("this is offers");
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
    }
  }
}
