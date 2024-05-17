import 'package:flutter/material.dart';
import 'package:graduationnn/config/dimens.dart';
import 'package:graduationnn/config/palette.dart';
import 'package:graduationnn/view/screens/doctor/signin_doctor_screen.dart';
import 'package:graduationnn/view/screens/patient/signin_patient_screen.dart';
import 'package:graduationnn/view/widgets/authenticate_doctor.dart';
import 'package:graduationnn/view/widgets/authenticate_patient.dart';
import 'package:graduationnn/view/widgets/custom_button_signin.dart';

class ChooseDoctorPatientScreen extends StatelessWidget {
  const ChooseDoctorPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Dimens.screenWidth(context),
          height: Dimens.screenHeight(context),
          color: Palette.colorPrimary600,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonSignIn(
                    txt: 'Patient',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthenticatePatient()));
                    },
                  ),
                  SizedBox(height: 20,),
                  CustomButtonSignIn(
                    txt: 'Doctor',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthenticateDoctor()));
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
