import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:take_taxi_driver/supabase/auth-supabase.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import 'package:take_taxi_driver/widgets/colors.dart';

// import '../widgets/form.dart';
import '../widgets/toast.dart';

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
  TextEditingController bodyNumber = new TextEditingController();
  TextEditingController seater = new TextEditingController();

  TextEditingController password = new TextEditingController();
  var supabase = SupabaseAuthService();
  TextEditingController passwordController = new TextEditingController();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: yellowNormal,
          title: const Text(
            "Sign Up",
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepCancel: () {
                bool isFirstStep = (currentStep == 0);
                if (isFirstStep) {
                  Navigator.of(context).pushNamed('/email-login');
                } else {
                  setState(() {
                    currentStep -= 1;
                  });
                }
              },
              onStepContinue: () {
                bool isLastStep = (currentStep == getSteps().length - 1);
                if (isLastStep) {
                  supabase.emailRegisterToSupabase(this.emailController.text, this.passwordController.text, this.firstName.text, this.lastName.text, this.phoneNumber.text, this.licenseNumber.text,
                      this.bodyNumber.text, int.parse(this.seater.text));
                  ToastMessage.showToastMessage();
                  Navigator.of(context).pushNamed('/email-login');
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepTapped: (step) => setState(() {
                currentStep = step;
              }),
              steps: getSteps(),
            )),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Account Info"),
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: firstName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: lastName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email Address',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Driver Details"),
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: licenseNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'License Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: bodyNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Body Number/Plate Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextFormField(
                controller: seater,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Seater',
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
