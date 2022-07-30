import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Title
            const SizedBox(height: 80),
            Text(
              'Forgot password',
              style: GoogleFonts.bebasNeue(
                fontSize: 56,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your email',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 50),
            //email textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                child: const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  )),
                ),
              ),
            ),

            //Send reset button
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
