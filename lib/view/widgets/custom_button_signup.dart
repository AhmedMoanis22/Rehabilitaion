import 'package:flutter/material.dart';
import 'package:graduationnn/config/palette.dart';
import 'package:graduationnn/view/widgets/custom_text_style.dart';

import '../../config/dimens.dart';

class CustomButtonSignUp extends StatelessWidget {
  String? txt;
  VoidCallback? onPressed;
  CustomButtonSignUp({super.key, required this.txt, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: Dimens.screenWidth(context),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Palette.colorPrimary600,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              )
          ),
          child: Text(txt!, style: txtButtonWhite(),)),
    );
  }
}
