import 'package:flutter/material.dart';
import 'package:take_taxi_driver/pages/home.dart';
import 'package:take_taxi_driver/widgets/colors.dart';

class HomeCard {
  static Widget homeCard(bookings, context, offerEnable) {
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
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 40, right: 40),
                decoration: BoxDecoration(
                  color: yellowNormal,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
                          child: Container(
                            height: 300,
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/icon/user-icon.png'),
                                  ),
                                  Text(
                                    bookings['first_name'] + ' ' + bookings['last_name'],
                                  ),
                                  TextField(
                                    controller: fare,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(hintText: "Offer"),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text('Pick-up: Central'), Text('Drop-off: SBMA')],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 0, bottom: 0, left: 40, right: 40),
                                    decoration: BoxDecoration(
                                      color: yellowNormal,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        await bookingService.createOffer(bookings['id'], fare.text);
                                      },
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(color: blackNormal),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  },
                  child: Text(
                    'OFFER',
                    style: TextStyle(color: blackNormal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget offerCard(bookings) {
    return Center(
      child: Text('Fare Offered: ' + bookings['fare'].toString()),
    );
  }
}
