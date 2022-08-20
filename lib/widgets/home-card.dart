import 'package:flutter/material.dart';
import 'package:take_taxi_driver/widgets/colors.dart';

class HomeCard {
  static Widget homeCard() {
    return Center(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/icon/user-icon.png'), // no matter how big it is, it won't overflow
              ),
              title: Text('Customer Name'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Pick-up: Central'), Text('Drop-off: SBMA')],
              ),
              trailing: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 40, right: 40),
                decoration: BoxDecoration(
                  color: yellowNormal,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'OFFER',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
