import 'package:flutter/material.dart';
import 'package:take_taxi_driver/pages/home.dart';
import 'package:take_taxi_driver/widgets/colors.dart';

class HomeCard {
  static Widget homeCard(bookings, context) {
    TextEditingController fare = new TextEditingController();
    return Center(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/icon/user-icon.png'),
              ),
              title: Text(
                bookings['first_name'] + ' ' + bookings['last_name'],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Pick-up: Central'), Text('Drop-off: SBMA')],
              ),
              trailing: Container(
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 40),
                decoration: BoxDecoration(
                  color: yellowNormal,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          bookings['first_name'] + ' ' + bookings['last_name'],
                        ),
                        content: TextField(
                          controller: fare,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "Offer"),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              bookingService.createOffer(
                                  bookings['booking_id'], fare.text);
                              Navigator.pop(context, 'Ok');
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    )
                  },
                  child: Text('OFFER'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
