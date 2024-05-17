import 'package:flutter/material.dart';
import 'package:graduationnn/view/widgets/custom_text_style.dart';

import '../../config/dimens.dart';

class CustomButtonSignIn extends StatelessWidget {
  String? txt;
  VoidCallback? onPressed;
  CustomButtonSignIn({super.key, required this.txt, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: Dimens.screenWidth(context),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
          child: Text(txt!, style: txtButton(),)),
    );
  }
}
