import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_taxi/supabase/auth-supabase.dart';
import '../firebase/firebase.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EmailLogin createState() => _EmailLogin();
}

class _EmailLogin extends State<EmailLogin> {
  TextEditingController emailController = new TextEditingController();

  TextEditingController password = new TextEditingController();
  var supabase = SupabaseInstance();

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
            const SizedBox(height: 10),
            const Text(
              'Book Your Taxi',
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

            //password textfield
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      )),
                ),
              ),
            ),

            //sign-in button
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                try {
                  await supabase.emailSignInToSupabase(
                      this.emailController.text, this.password.text);
                  Navigator.of(context).pushNamed(
                    '/home',
                    arguments: 'Hello from the first page!',
                  );
                  print('Run signin function');
                } catch (e) {
                  print(e);
                }
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
                      'Sign In',
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

            //register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Not a member?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    ' Register now',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            //forgot password
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: (const Text(
                    'Forgot Password?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
