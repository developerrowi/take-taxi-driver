import 'package:flutter/material.dart';

class HomeCard {
  static Widget homeCard(booking) {
    return Center(
      child: Card(
        child: SizedBox(
          height: 100,
          child: Center(child: Text(booking['passenger_email'])),
        ),
      ),
    );
  }
}
