import 'package:flutter/material.dart';
import '../../../../config/dimens.dart';
import '../../../../config/palette.dart';
import '../../../widgets/custom_button_signup.dart';
import '../../../widgets/flick_video_screen.dart';

class AbductionScreen extends StatefulWidget {
  const AbductionScreen({super.key});

  @override
  State<AbductionScreen> createState() => _AbductionScreenState();
}

class _AbductionScreenState extends State<AbductionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Abduction Exercise', style: TextStyle(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlickVideoScreen('assets/videos/e2_s10_t1.mp4'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Shoulder abduction exercises specifically "
                      "target the deltoid muscles, particularly the "
                      "lateral deltoid, which is responsible for "
                      "lifting the arms away from the body's midline. "
                      "Strengthening the shoulder abductors is crucial "
                      "for improving shoulder stability, mobility, and "
                      "function, as well as enhancing overall upper body "
                      "strength and posture.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 24,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Stand with your back against a wall, with your feet hip-width apart and your knees slightly bent.",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('2 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Press your lower back into the wall and keep your head, upper back, and buttocks in contact with the wall throughout the exercise.",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('3 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Raise both arms out to the sides and bend your elbows to 90 degrees, forming a goalpost position.",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('4 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Slowly slide your arms up the wall as far as you can while keeping your elbows and wrists in contact with the wall.",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('5 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Hold the raised position for a moment, then slide your arms back down to the starting position.",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('6 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Focus on maintaining contact with the wall and keeping your shoulder blades engaged.",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24,),
                  CustomButtonSignUp(txt: 'Continue', onPressed: (){

                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
