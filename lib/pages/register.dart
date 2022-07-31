import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import '../widgets/form.dart';
import '../widgets/toast.dart';

import '../firebase/firebase.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController licenseNumber = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  var firebase = FireBaseInstance();

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
              'Register',
              style: GoogleFonts.bebasNeue(
                fontSize: 56,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Register an Account',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 50),
            //First Name textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: firstName,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                      )),
                ),
              ),
            ),

            //Last Name textfield
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: lastName,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Last Name',
                      )),
                ),
              ),
            ),

            //Phone Number textfield
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                      )),
                ),
              ),
            ),

            //License textfield
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: licenseNumber,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ID/License Number',
                      )),
                ),
              ),
            ),

            //Username Email textfield
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      )),
                ),
              ),
            ),

            //password textfields
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200], border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      )),
                ),
              ),
            ),

            //register button
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await firebase.emailRegisterToFireBase(this.emailController.text, this.passwordController.text);
                print('Register Firebase');
                ToastMessage.showToastMessage();
                Navigator.of(context).pushNamed('/email-login');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }
}
