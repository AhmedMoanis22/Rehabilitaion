import 'package:flutter/material.dart';
import 'package:graduationnn/view/screens/patient/received_exercise/abduction_screen.dart';
import 'package:graduationnn/view/screens/patient/received_exercise/flexion_screen.dart';
import 'package:graduationnn/view/widgets/custom_button_signup.dart';

import 'external_rotation_screen.dart';

class ReceivedExerciseScreen extends StatefulWidget {
  const ReceivedExerciseScreen({super.key});

  @override
  State<ReceivedExerciseScreen> createState() => _ReceivedExerciseScreenState();
}

class _ReceivedExerciseScreenState extends State<ReceivedExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Received Exercise', style: TextStyle(
            color: Colors.black
        ),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonSignUp(txt: 'Abduction', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AbductionScreen()));
            }),
            SizedBox(height: 16,),
            CustomButtonSignUp(txt: 'Flexion', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FlexionScreen()));
            }),
            SizedBox(height: 16,),
            CustomButtonSignUp(txt: 'External rotation', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExternalRotationScreen()));
            }),
          ],
        ),
      ),
    );
  }
}
