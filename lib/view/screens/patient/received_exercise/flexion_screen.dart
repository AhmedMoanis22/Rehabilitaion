import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/custom_button_signup.dart';
import '../../../widgets/flick_video_screen.dart';
import 'ar_screen.dart';

class FlexionScreen extends StatefulWidget {
  const FlexionScreen({super.key});

  @override
  State<FlexionScreen> createState() => _FlexionScreenState();
}

class _FlexionScreenState extends State<FlexionScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flexion', style: TextStyle(
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
            FlickVideoScreen('assets/videos/e1_s10_t1.mp4'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Flexion exercises target muscles that bring limbs closer to the body's midline, primarily focusing on the muscles responsible for forward movement.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 24,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Stand tall with your feet shoulder-width apart and your arms by your sides.",
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
                        child: Text("Keeping your arms straight, slowly raise both arms forward until they are parallel to the floor.",
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
                        child: Text("Keep your palms facing downward throughout the movement.",
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
                        child: Text("Hold the raised position for a moment, then slowly lower your arms back to the starting position.",
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24,),
                  CustomButtonSignUp(txt: 'Continue', onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArScreen()));
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
