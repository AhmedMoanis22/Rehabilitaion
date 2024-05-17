import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  FormFieldValidator? validator;
  TextInputType? input;
  bool? obscureText;
  CustomTextFormField({super.key, required this.controller, required this.label, this.validator, this.input, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      keyboardType: input,
      controller: controller,
      obscureText: obscureText!,
      validator: validator,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text(label!),
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(15),
        ),

      ),
    );
  }
}
