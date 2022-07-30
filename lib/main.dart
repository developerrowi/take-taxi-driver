import 'package:flutter/material.dart';
// import 'package:pocket_taxi/pages/animation/button_animation.dart';
import 'package:pocket_taxi/firebase/firebase.dart';
import 'package:pocket_taxi/routes.dart';
import 'package:pocket_taxi/services/auth.service.dart';
import 'package:pocket_taxi/services/location.service.dart';
import 'package:pocket_taxi/supabase/auth-supabase.dart';

import 'package:pocket_taxi/widgets/colors.dart';
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
