import 'package:flutter/material.dart';

import '../../config/palette.dart';

class CustomTextFormFieldSignUp extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  FormFieldValidator? validator;
  TextInputType? input;
  bool? obscureText;
  CustomTextFormFieldSignUp({super.key, required this.controller, required this.hint, this.validator, this.input, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      keyboardType: input,
      controller: controller,
      validator: validator,
      obscureText: obscureText!,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Palette.colorPrimary600,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.colorPrimary200,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
