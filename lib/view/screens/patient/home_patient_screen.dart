import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/config/dimens.dart';
import 'package:graduationnn/config/palette.dart';
import 'package:graduationnn/view/screens/patient/medical_history_screen.dart';
import 'package:graduationnn/view/screens/patient/received_exercise/received_exercise_screen.dart';
import 'package:graduationnn/view/widgets/custom_text_style.dart';

import '../../../services/database.dart';
import '../../../services/home_patient/logic/home_patient_cubit.dart';
import '../../../services/home_patient/logic/home_patient_state.dart';
import 'doctors_screen.dart';

class HomePatientScreen extends StatefulWidget {
  const HomePatientScreen({super.key});

  @override
  State<HomePatientScreen> createState() => _HomePatientScreenState();
}

class _HomePatientScreenState extends State<HomePatientScreen> {
  bool? isChecked = false;

  final databaseMethods = DatabaseMethods();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final String collectionPatients = 'patients';
  final String collectionDoctors = 'doctors';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePatientCubit()..getDataHome(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomePatientCubit, HomePatientState>(
            builder: (context, state) {
              if (state is HomePatientLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container(
                width: Dimens.screenWidth(context),
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome ${context.read<HomePatientCubit>().patientModel!.name}',
                      style: title(),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Connect to special doctors around you',
                      style: txtDes(),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text('Doctors', style: txtCat(),),
                    //     Text('View All', style: txtView(),),
                    //   ],
                    // ),
                    // SizedBox(height: 10,),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DoctorsScreen()));
                                },
                                child: Container(
                                  // width: 166,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      color: Palette.colorPrimary600,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: Text(
                                    'Doctor’s',
                                    style: txtCon(),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReceivedExerciseScreen()));
                                },
                                child: Container(
                                  // width: 166,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      color: Palette.colorPrimary600,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: Text(
                                    'Received Exercise',
                                    textAlign: TextAlign.center,
                                    style: txtCon(),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MedicalHistoryScreen()));
                                },
                                child: Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                      color: Palette.colorPrimary600,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: Text(
                                    'Medical history',
                                    style: txtCon(),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 166,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      color: Palette.colorPrimary600,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: Text(
                                      'Start chat with doctors',
                                      textAlign: TextAlign.center,
                                      style: txtCon(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
