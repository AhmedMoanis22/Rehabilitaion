import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/services/doctors_auth/sign_up/logic/sign_up_cubit.dart';
import 'package:graduationnn/services/doctors_auth/sign_up/logic/sign_up_state.dart';
import 'package:graduationnn/view/widgets/custom_button_signup.dart';

import '../../../config/dimens.dart';
import '../../../services/database.dart';
import '../../widgets/custom_text_form_field_signup.dart';
import '../../widgets/custom_text_style.dart';
import 'signin_doctor_screen.dart';

class SignUpDoctorScreen extends StatefulWidget {
  const SignUpDoctorScreen({super.key});

  @override
  State<SignUpDoctorScreen> createState() => _SignUpDoctorScreenState();
}

class _SignUpDoctorScreenState extends State<SignUpDoctorScreen> {
  bool isLoading = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  final fireStore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubitDoctor(),
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
                            'SIGN UP DOCTOR',
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
                      'Specialization',
                      style: txtTitle(),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFormFieldSignUp(
                      obscureText: false,
                      hint: 'Enter your specialization',
                      controller: specializationController,
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
                      hint: 'Password',
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<SignUpCubitDoctor, SignUpDoctorState>(
                        listener: (context, state) {
                      if (state is CretaeUserSuccess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignInDoctorScreen()));
                      }
                    }, builder: (context, state) {
                      return CustomButtonSignUp(
                          txt: 'Sign Up',
                          onPressed: () async {
                            context.read<SignUpCubitDoctor>().createAccount(
                                  name: usernameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  age: int.parse(ageController.text),
                                  specialization: specializationController.text,
                                );
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                            }
                          });
                    }),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignInDoctorScreen()));
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
