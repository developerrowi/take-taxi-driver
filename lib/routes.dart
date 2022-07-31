import 'package:flutter/material.dart';
import 'package:take_taxi_driver/main.dart';
import 'package:take_taxi_driver/pages/email_login.dart';
import 'package:take_taxi_driver/pages/forgotpassword.dart';
import 'package:take_taxi_driver/pages/home.dart';
import 'package:take_taxi_driver/pages/login.dart';
import 'package:take_taxi_driver/pages/loading.dart';
import 'package:take_taxi_driver/pages/register.dart';
import 'package:take_taxi_driver/services/auth.service.dart';

class RouteGenerator {
  late Object firebase;
  late Object firebaseAuth;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    AuthService _authService = AuthService();

    var routeName = settings.name;

    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Loading());
      case '/email-login':
        return MaterialPageRoute(builder: (_) => EmailLogin());
      // case '/email-login':
      //   return MaterialPageRoute(builder: (_) => EmailLogin());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/forgot':
        return MaterialPageRoute(builder: (_) => Forgot());
      case '/home':
        if (!_authService.isLoggedIn) {
          return MaterialPageRoute(builder: (_) => EmailLogin());
        }
        return MaterialPageRoute(builder: (_) => Home());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
