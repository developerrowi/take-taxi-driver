import 'dart:async';

import 'package:flutter/material.dart';
import 'package:take_taxi_driver/services/location.service.dart';
import 'package:take_taxi_driver/services/directions.service.dart';
import 'package:take_taxi_driver/supabase/booking.dart';
import 'package:take_taxi_driver/widgets/home-card.dart';

import '../supabase/user-location.dart';
import '../widgets/drawer.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/main-map.dart';

LocationService locationService = LocationService();
UserLocationService userLocationService = UserLocationService();
BookingService bookingService = BookingService();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var bookings = [];
  var offers = [];

  late Timer _timer;

  LocationService _locationService = LocationService();

  late final MapController mapController;
  var markers = <Marker>[
    Marker(
      point: LatLng(locationService.currentLocation.latitude, locationService.currentLocation.longitude),
      builder: (ctx) => Image.asset(
        'assets/icon/taketaxi-icon-v3.png',
        height: 1.0,
        width: 1.0,
        fit: BoxFit.cover,
      ),
    ),
  ];

  var directions = <Polyline>[
    Polyline(points: [
      LatLng(14.839347, 120.288421),
      LatLng(14.839479, 120.28856),
      LatLng(14.839917, 120.288144),
      LatLng(14.840357, 120.287705),
      LatLng(14.840565, 120.287908),
    ], color: Colors.blue)
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
    this.fetchLocationInterval();
    addNewMarker();
  }

  dispose() {
    _timer.cancel(); // you need this
    super.dispose();
  }

  void fetchLocationInterval() async {
    await _locationService.getCurrentLocation();
  }

  void fetchUserLocation(email) async {
    await userLocationService.getUserLocation(email);
  }

  fetchBooking() async {
    var data = await bookingService.getBookings();
    return data;
  }

  fetchOffers() async {
    var data = await bookingService.getOffersByDriver();
    return data;
  }

  addNewMarker() async {
    var selectedEmail = 'todas@gmail.com';
    await markerLogic();
    this.fetchLocationInterval();
    // this.fetchUserLocation(selectedEmail);
    _timer = Timer.periodic(new Duration(milliseconds: 2500), (timer) async {
      await markerLogic();
    });
  }

  markerLogic() async {
    bookings = await this.fetchBooking();
    offers = await this.fetchOffers();
    var x = locationService.currentLocation.latitude;
    var y = locationService.currentLocation.longitude;

    // var userX = userLocationService.currentUser.latitude;
    // var userY = userLocationService.currentUser.longitude;
    print(markers[0].builder);
    markers.clear();

    // Driver
    markers.add(Marker(
      point: LatLng(x, y),
      builder: (ctx) => Image.asset(
        'assets/icon/driver-icon.png',
        height: 1.0,
        width: 1.0,
        fit: BoxFit.cover,
      ),
    ));

    // User
    // markers.add(Marker(
    //   point: LatLng(userX, userY),
    //   builder: (ctx) => Image.asset(
    //     'assets/icon/user-icon.png',
    //     height: 1.0,
    //     width: 1.0,
    //     fit: BoxFit.cover,
    //   ),
    // ));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cardWidgets = [];

    for (var i = 0; i < offers.length; i++) {
      print(offers[i]);
      cardWidgets.add(HomeCard.offerCard(offers[i]));
    }

    for (var i = 0; i < bookings.length; i++) {
      if (offers.isEmpty)
        cardWidgets.add(HomeCard.homeCard(bookings[i], context, true));
      else
        cardWidgets.add(HomeCard.homeCard(bookings[i], context, false));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: buildDrawer(context, '/home'),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            SizedBox(
              height: 400.0,
              child: MainMap.mainMap(markers, directions, mapController),
            ),
            Flexible(
              child: ListView(scrollDirection: Axis.vertical, shrinkWrap: true, children: cardWidgets),
            )
          ],
        ),
      ),
    );
  }
}
