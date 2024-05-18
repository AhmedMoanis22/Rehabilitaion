import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/palette.dart';
import '../../../services/home_doctor/logic/home_doctor_cubit.dart';
import '../../../services/home_doctor/logic/home_doctor_state.dart';
import 'chat_doctor_screen.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  void initState() {
    context.read<HomeDoctorCubit>().getPatientData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeDoctorCubit, HomeDoctorState>(
          builder: (context, state) {
        if (state is HomeDoctorPatientDataLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Image.network(
                  '${context.read<HomeDoctorCubit>().patientModel!.image}',
                  height: 80,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '${context.read<HomeDoctorCubit>().patientModel!.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Age: ${context.read<HomeDoctorCubit>().patientModel!.age}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Gender: Male',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.phone,
                    ),
                    Text(
                      '${context.read<HomeDoctorCubit>().patientModel!.phone}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatDocotorScreen()));
        },
        backgroundColor: Palette.colorPrimary600,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
