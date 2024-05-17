import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/helper/helperfunctions.dart';
import 'package:graduationnn/models/patient_model.dart';

import '../../../services/home_doctor/logic/home_doctor_cubit.dart';
import 'patient_details.dart';

class PatientChat extends StatelessWidget {
  const PatientChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return buildChatCard(
            context, context.read<HomeDoctorCubit>().patientList[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: context.read<HomeDoctorCubit>().patientList.length,
    );
  }

  Widget buildChatCard(BuildContext context, PatientModel model) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PatientDetails()));
        MySharedPreferences.setString('PatientDetailsId', model.uId!);
      },
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Image.network(
                    '${model.image}',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
