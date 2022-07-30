import 'package:flutter/material.dart';
// import 'package:take_taxi_driver/pages/animation/button_animation.dart';
import 'package:take_taxi_driver/firebase/firebase.dart';
import 'package:take_taxi_driver/routes.dart';
import 'package:take_taxi_driver/services/auth.service.dart';
import 'package:take_taxi_driver/services/location.service.dart';
import 'package:take_taxi_driver/supabase/auth-supabase.dart';

import 'package:take_taxi_driver/widgets/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  AuthService _authService = AuthService();
  LocationService _locationService = LocationService();
  await _locationService.getCurrentLocation();

  var supaBase = new SupabaseAuthService();
  supaBase.initializeSupabase();

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
