import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/patient/signin_patient_screen.dart';
import 'package:graduationnn/view/screens/patient/signup_patient_screen.dart';

class AuthenticatePatient extends StatefulWidget {
  const AuthenticatePatient({super.key});

  @override
  State<AuthenticatePatient> createState() => _AuthenticatePatientState();
}

class _AuthenticatePatientState extends State<AuthenticatePatient> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return const SignInPatientScreen();
    } else {
      return const SignUpPatientScreen();
    }
  }
}
