import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/services/home_patient/logic/home_patient_cubit.dart';

import '../../../config/palette.dart';
import '../../../services/home_patient/logic/home_patient_state.dart';
import 'chat_patient_screen.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  void initState() {
    context.read<HomePatientCubit>().getDoctorData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomePatientCubit, HomePatientState>(
          builder: (context, state) {
        if (state is HomePatientDoctorDataLoading) {
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
                  '${context.read<HomePatientCubit>().doctorModel!.image}',
                  height: 80,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '${context.read<HomePatientCubit>().doctorModel!.name}',
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
                  'Specilization: ${context.read<HomePatientCubit>().doctorModel!.specialization}',
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
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Age: ${context.read<HomePatientCubit>().doctorModel!.age}',
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
                      '${context.read<HomePatientCubit>().doctorModel!.phone}',
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChatPatientScreen()));
        },
        backgroundColor: Palette.colorPrimary600,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
