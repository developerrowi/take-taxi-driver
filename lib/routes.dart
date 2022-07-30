import 'package:flutter/material.dart';
import 'package:pocket_taxi/main.dart';
import 'package:pocket_taxi/pages/email_login.dart';
import 'package:pocket_taxi/pages/forgotpassword.dart';
import 'package:pocket_taxi/pages/home.dart';
import 'package:pocket_taxi/pages/login.dart';
import 'package:pocket_taxi/pages/loading.dart';
import 'package:pocket_taxi/pages/register.dart';
import 'package:pocket_taxi/services/auth.service.dart';

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
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/email-login':
        return MaterialPageRoute(builder: (_) => EmailLogin());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/forgot':
        return MaterialPageRoute(builder: (_) => Forgot());
      case '/home':
        if (!_authService.isLoggedIn) {
          return MaterialPageRoute(builder: (_) => Login());
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
