import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/services/doctors_auth/login/logic/login_cubit.dart';
import 'package:graduationnn/view/screens/doctor/home_doctor_screen.dart';

import '../../../config/dimens.dart';
import '../../../config/palette.dart';
import '../../../helper/helperfunctions.dart';
import '../../../services/doctors_auth/login/logic/login_state.dart';
import '../../widgets/custom_button_signin.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_text_style.dart';
import 'signup_doctor_screen.dart';

class SignInDoctorScreen extends StatefulWidget {
  const SignInDoctorScreen({super.key});

  @override
  State<SignInDoctorScreen> createState() => _SignInDoctorScreenState();
}

class _SignInDoctorScreenState extends State<SignInDoctorScreen> {
  bool isChecked = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginDoctorCubit(),
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
                            'SIGN IN DOCTOR',
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
                              controller: emailController,
                              label: 'Email'),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              obscureText: true,
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
                                      fillColor:
                                        const MaterialStatePropertyAll(Colors.white)  ,
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
                          BlocConsumer<LoginDoctorCubit, LoginDocotorState>(
                              listener: (context, state) {
                            if (state is LoginSuccess) {
                              MySharedPreferences.setString(
                                      'DoctorId', state.uId)
                                  .then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeDoctorScreen()),
                                    (route) => false);
                              });
                            }
                          }, builder: (context, state) {
                            return CustomButtonSignIn(
                                txt: 'Login',
                                onPressed: () {
                                  context.read<LoginDoctorCubit>().loginAccount(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  // if (_key.currentState!.validate()) {
                                  //   User? user =
                                  //       await Auth.signInUsingEmailPassword(
                                  //     email: emailController.text,
                                  //     password: passwordController.text,
                                  //     context: context,
                                  //   );
                                  //   if (user != null) {
                                  //     Navigator.of(context).pushReplacement(
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               HomeDoctorScreen(user: user)),
                                  //     );
                                  //   }
                                  // }
                                });
                          }),
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
                                              const SignUpDoctorScreen()));
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
