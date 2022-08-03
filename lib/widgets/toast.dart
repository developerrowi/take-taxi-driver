import "package:fluttertoast/fluttertoast.dart";
import 'package:flutter/material.dart';

// class ToastMessage extends StatefulWidget {
//   ToastMessage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _ToastMessage createState() => _ToastMessage();
// }

// class _ToastMessage extends State<ToastMessage> {
//   void _showToastMessage {
//     Fluttertoast.showToast(
//       msg: "Test Toast",
//       toastLength: Toast.LENGTH_LONG,
//       fontSize: 20,
//       textColor: Colors.green,
//       gravity: ToastGravity.CENTER,);
//   }
// }

Widget toast = Container(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: Colors.greenAccent,
  ),
  child: Text("This is a Custom Toast"),
);

class ToastMessage {
  static showToastMessage() {
    Fluttertoast.showToast(
        msg: "Success",
        toastLength: Toast.LENGTH_LONG,
        fontSize: 14,
        textColor: Colors.black,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white);
  }
}
