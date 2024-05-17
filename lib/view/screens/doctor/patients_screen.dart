import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/home_doctor/logic/home_doctor_cubit.dart';
import '../../../services/home_doctor/logic/home_doctor_state.dart';
import 'home_doctor_patient_chat.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final String collectionPatients = 'patients';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeDoctorCubit()..getPatientList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Patients',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<HomeDoctorCubit, HomeDoctorState>(
            builder: (context, state) {
          if (state is GetPatientListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const PatientChat();
        }),
      ),
    );
  }
}
