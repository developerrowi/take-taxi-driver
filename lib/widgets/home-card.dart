import 'package:flutter/material.dart';

class HomeCard {
  static Widget homeCard() {
    return const Center(
      child: Card(
        child: SizedBox(
          height: 100,
          child: Center(child: Text('Customer Info Here')),
        ),
      ),
    );
  }
}
