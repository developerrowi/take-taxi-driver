import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_taxi/services/auth.service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pocket_taxi/services/auth.service.dart';

final supabase = Supabase.instance.client;
AuthService authService = AuthService();

class SupabaseInstance {
  void initializeSupabase() async {
    await Supabase.initialize(
        url: 'https://jtdgwvhymxpzxnlhzaoh.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp0ZGd3dmh5bXhwenhubGh6YW9oIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTc4OTg0MjYsImV4cCI6MTk3MzQ3NDQyNn0.I0wNui0Do171HTwDnDlncubWblUibox3dcdifP41TGc');

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
      print(currentUser);
      final error = res.error;
    } catch (e) {}
  }

  emailRegisterToSupabase(String email, String password, String firstName,
      String lastName, String phoneNumber, String licenseNumber) async {
    try {
      final res = await supabase.auth.signUp(email, password);
      final updates = {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'license_number': licenseNumber
      };

      final driverDetails =
          await supabase.from('driver_details').insert(updates).execute();
      final error = driverDetails.error;
      if (error != null) {
        print(error.message);
      } else {
        print('Successfully Registered!');
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
