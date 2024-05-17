import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/home_patient/logic/home_patient_cubit.dart';
import '../../../services/home_patient/logic/home_patient_state.dart';
import 'home_patient_doctors_chat.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final String collectionDoctors = 'doctors';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePatientCubit()..getDoctorList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Doctors',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<HomePatientCubit, HomePatientState>(
            builder: (context, state) {
          if (state is HomePatientLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const DoctorChat();
        }),
      ),
    );
  }
}
