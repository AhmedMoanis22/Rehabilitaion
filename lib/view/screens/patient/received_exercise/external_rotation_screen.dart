import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/custom_button_signup.dart';
import '../../../widgets/flick_video_screen.dart';

class ExternalRotationScreen extends StatefulWidget {
  const ExternalRotationScreen({super.key});

  @override
  State<ExternalRotationScreen> createState() => _ExternalRotationScreenState();
}

class _ExternalRotationScreenState extends State<ExternalRotationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'External Rotation', style: TextStyle(
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
            FlickVideoScreen('assets/videos/e3_s10_t1.mp4'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("External rotation exercises target muscles that rotate limbs away from the body's midline, primarily focusing on the muscles responsible for outward rotation. These exercises are particularly important for strengthening the muscles around the shoulder joint, enhancing shoulder stability, and improving posture.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(height: 24,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1 _', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text("Securely anchor one end of a resistance band to a stationary object at waist height.",
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
                        child: Text("Stand sideways to the anchor point with the arm closest to the anchor holding the other end of the band.",
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
                        child: Text("Keep your elbow bent at a 90-degree angle and your forearm parallel to the floor.",
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
                        child: Text("Externally rotate your shoulder by pulling the band outward, away from your body, while keeping your elbow tucked into your side.",
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
                        child: Text("Hold the end position for a moment, then slowly return to the starting position.",
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
