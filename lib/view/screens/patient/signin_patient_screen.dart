import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/view/screens/patient/home_patient_screen.dart';
import 'package:graduationnn/view/screens/patient/signup_patient_screen.dart';

import '../../../config/dimens.dart';
import '../../../config/palette.dart';
import '../../../helper/helperfunctions.dart';
import '../../../services/patients_auth/login/logic/login_cubit.dart';
import '../../../services/patients_auth/login/logic/login_state.dart';
import '../../../services/validator.dart';
import '../../widgets/custom_button_signin.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_text_style.dart';

class SignInPatientScreen extends StatefulWidget {
  const SignInPatientScreen({super.key});

  @override
  State<SignInPatientScreen> createState() => _SignInPatientScreenState();
}

class _SignInPatientScreenState extends State<SignInPatientScreen> {
  bool isChecked = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPatientCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _key,
            child: SizedBox(
              height: Dimens.screenHeight(context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: Dimens.screenWidth(context),
                      padding: const EdgeInsets.only(left: 24, top: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SIGN IN PATIENT',
                            style: title(),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Sign in if you already have an account',
                            style: txtDes(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      width: double.infinity,
                      height: Dimens.screenHeight(context),
                      decoration: const BoxDecoration(
                          color: Palette.colorPrimary600,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(30))),
                      child: Column(
                        children: [
                          CustomTextFormField(
                              obscureText: false,
                              validator: (value) =>
                                  Validator.validateEmail(email: value!),
                              controller: emailController,
                              label: 'Email'),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              obscureText: true,
                              input: TextInputType.visiblePassword,
                              validator: (value) =>
                                  Validator.validatePassword(password: value!),
                              controller: passwordController,
                              label: 'Password'),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      value: isChecked,
                                      // fillColor:
                                      //     WidgetStateProperty.all(Colors.white),
                                      checkColor: Palette.colorPrimary600,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      onChanged: (val) {
                                        setState(() {
                                          isChecked = !isChecked;
                                        });
                                      }),
                                  Text(
                                    'Remember Me',
                                    style: txtSign(),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Forget Password?',
                                    style: txtSign(),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocConsumer<LoginPatientCubit, LoginPatientState>(
                            listener: (context, state) {
                              if (state is LoginSuccess) {
                                MySharedPreferences.setString(
                                        'PatientId', state.uId)
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePatientScreen()),
                                      (route) => false);
                                });
                              }
                            },
                            builder: (context, state) {
                              return CustomButtonSignIn(
                                  txt: 'Login',
                                  onPressed: () async {
                                    context
                                        .read<LoginPatientCubit>()
                                        .loginPatientAccount(
                                            email: emailController.text,
                                            password: passwordController.text);
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
                                "Don't Have an account? ",
                                style: txtHave(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPatientScreen()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: txtSign(),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
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
