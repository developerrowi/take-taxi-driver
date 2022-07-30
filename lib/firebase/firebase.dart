import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:take_taxi_driver/services/auth.service.dart';
import 'firebase_options.dart';

class FireBaseInstance {
  void initializeFirebase() async {
    AuthService authService = AuthService();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // await FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        authService.setIsLoggedIn(false);
      } else {
        print('User is signed in!');
        authService.setIsLoggedIn(true);
        authService.setIsEmailVerified(user.emailVerified);
      }
      print(user);
    });
  }

  emailSignInToFirebase(String email, String password) async {
    try {
      print(email);
      print(password);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  emailRegisterToFireBase(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  googleSignInToFirebase() async {
    print('Logging in to google.');
    var googleSignIn = await GoogleSignIn().signIn();

    if (googleSignIn == null) return;

    var googleAuth = await googleSignIn.authentication;

    var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        await linkCredentials(credential, "facebook");
      }
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  facebookSignInToFirebase() async {
    var facebookSignIn = await FacebookAuth.instance.login();
    var credential =
        FacebookAuthProvider.credential(facebookSignIn.accessToken!.token);
    try {
      print("Sign In Through Facebook");

      switch (facebookSignIn.status) {
        case LoginStatus.success:
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          return;

        case LoginStatus.cancelled:
          print("Facebook Login Cancelled");
          return;
        case LoginStatus.failed:
          print("Facebook Login Failed");
          return;
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        await linkCredentials(credential, "facebook");
      }
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  logoutFirebase() async {
    try {
      AuthService authService = AuthService();
      authService.setIsLoggedIn(false);
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  linkCredentials(AuthCredential credential, String type) async {
    if (type == 'facebook') {
      var googleSignIn = await GoogleSignIn().signIn();
      if (googleSignIn == null) return;
      var googleAuth = await googleSignIn.authentication;

      var googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(googleCredential);
    }

    if (type == 'google') {
      var facebookSignIn = await FacebookAuth.instance.login();
      var facebookCredential =
          FacebookAuthProvider.credential(facebookSignIn.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookCredential);
    }

    var linkCreds =
        await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  }
}
