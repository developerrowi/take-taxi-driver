import 'package:flutter/material.dart';
// import 'package:take_taxi_driver/pages/animation/button_animation.dart';
import 'package:take_taxi_driver/routes.dart';
import 'package:take_taxi_driver/services/auth.service.dart';
import 'package:take_taxi_driver/services/location.service.dart';
import 'package:take_taxi_driver/supabase/auth-supabase.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://jtdgwvhymxpzxnlhzaoh.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp0ZGd3dmh5bXhwenhubGh6YW9oIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTc4OTg0MjYsImV4cCI6MTk3MzQ3NDQyNn0.I0wNui0Do171HTwDnDlncubWblUibox3dcdifP41TGc');

  var supaBase = SupabaseAuthService();
  supaBase.initializeSupabase();
  AuthService _authService = AuthService();
  LocationService _locationService = LocationService();
  await _locationService.getCurrentLocation();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late Object firebase;
  late Object firebaseAuth;

  MyApp() {
    print('Test');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Initially display FirstPage
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
