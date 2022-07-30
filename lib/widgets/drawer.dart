import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocket_taxi/firebase/firebase.dart';
import 'package:pocket_taxi/supabase/auth-supabase.dart';

var supabase = new SupabaseInstance();

Widget _buildMenuItem(
    BuildContext context, Widget title, String routeName, String currentRoute) {
  var isSelected = routeName == currentRoute;

  return ListTile(
    title: title,
    selected: isSelected,
    onTap: () {
      if (isSelected) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, routeName);
      }
    },
  );
}

Widget _logout(
    BuildContext context, Widget title, String routeName, String currentRoute) {
  var isSelected = routeName == currentRoute;

  return ListTile(
    title: title,
    selected: isSelected,
    onTap: () {
      supabase.logoutSupabase();
      Navigator.pushReplacementNamed(context, '/email-login');
    },
  );
}

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Center(
            child: Text('Take Taxi'),
          ),
        ),
        _buildMenuItem(
          context,
          const Text('Book'),
          '/home',
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text('History'),
          '/home',
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text('Contact Us'),
          '/home',
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text('Settings'),
          '/home',
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text('Terms and Conditions'),
          '/home',
          currentRoute,
        ),
        _logout(
          context,
          const Text('Logout'),
          '/home',
          currentRoute,
        ),
        Container(
          decoration: BoxDecoration(),
        )
      ],
    ),
  );
}
