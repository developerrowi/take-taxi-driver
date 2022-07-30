import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase/firebase.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pocket_taxi/widgets/colors.dart';
import 'package:pocket_taxi/widgets/SocialButtons.dart';

final Color facebookColor = const Color(0xff39579A);
final Color googleColor = const Color(0xffDF4A32);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();

  TextEditingController password = new TextEditingController();
  var firebase = FireBaseInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/icon/taketaxi-icon-v3.png',
              height: 100,
              width: 100,
            ),
            //Title
            const SizedBox(height: 10),
            Text(
              'Take Taxi',
              style: GoogleFonts.bebasNeue(
                fontSize: 56,
              ),
            ),

            SocialButtons.socialButtonRect('Login with Facebook', facebookColor,
                FontAwesomeIcons.facebookF, onTap: () async {
              await firebase.facebookSignInToFirebase();
              Navigator.of(context)
                  .pushNamed('/home', arguments: 'Hello from the first page!');
            }),

            SocialButtons.socialButtonRect(
                'Login with google', googleColor, FontAwesomeIcons.googlePlusG,
                onTap: () async {
              await firebase.googleSignInToFirebase();
              Navigator.of(context)
                  .pushNamed('/home', arguments: 'Hello from the first page!');
            }),

            SocialButtons.socialNoIcon('Sign In', blackNormal, null,
                onTap: () async {
              Navigator.of(context).pushNamed('/email-login');
            }),
          ]),
        ),
      ),
    );
  }
}
