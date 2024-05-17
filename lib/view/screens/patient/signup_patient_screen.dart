import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/view/widgets/custom_button_signup.dart';

import '../../../config/dimens.dart';
import '../../../services/database.dart';
import '../../../services/patients_auth/sign_up/logic/sign_up_cubit.dart';
import '../../../services/patients_auth/sign_up/logic/sign_up_state.dart';
import '../../../services/validator.dart';
import '../../widgets/custom_text_form_field_signup.dart';
import '../../widgets/custom_text_style.dart';

class SignUpPatientScreen extends StatefulWidget {
  const SignUpPatientScreen({super.key});

  @override
  State<SignUpPatientScreen> createState() => _SignUpPatientScreenState();
}

class _SignUpPatientScreenState extends State<SignUpPatientScreen> {
  bool isLoading = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpPatientCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 60, right: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Dimens.screenWidth(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SIGN UP PATIENT',
                            style: title(),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Please file this information to complete Registration',
                            style: txtDes(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Username',
                      style: txtTitle(),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormFieldSignUp(
                      obscureText: false,
                      validator: (value) =>
                          Validator.validateName(name: value!),
                      hint: 'Enter your username',
                      controller: usernameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email',
                      style: txtTitle(),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormFieldSignUp(
                      obscureText: false,
                      validator: (value) =>
                          Validator.validateEmail(email: value!),
                      hint: 'Enter your email',
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Age',
                      style: txtTitle(),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormFieldSignUp(
                      obscureText: false,
                      hint: 'Enter your age',
                      controller: ageController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone Number',
                      style: txtTitle(),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormFieldSignUp(
                      obscureText: false,
                      input: TextInputType.phone,
                      hint: 'Enter your phone number',
                      controller: phoneController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Password',
                      style: txtTitle(),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormFieldSignUp(
                      obscureText: true,
                      validator: (value) =>
                          Validator.validatePassword(password: value!),
                      hint: 'Password',
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<SignUpPatientCubit, SignUpPatientState>(
                      listener: (context, state) {
                        if (state is CreateUserPatientSuccess) {
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return CustomButtonSignUp(
                            txt: 'Sign Up',
                            onPressed: () {
                              context
                                  .read<SignUpPatientCubit>()
                                  .createPatientAccount(
                                      name: usernameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      age: int.parse(ageController.text));
                            });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: txtHaveB(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In',
                            style: txtSignB(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
