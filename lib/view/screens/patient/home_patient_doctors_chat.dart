import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/helper/helperfunctions.dart';
import 'package:graduationnn/models/user_model.dart';
import 'package:graduationnn/services/home_patient/logic/home_patient_cubit.dart';
import 'package:graduationnn/view/screens/patient/doctor_details.dart';

class DoctorChat extends StatelessWidget {
  const DoctorChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return buildChatCard(
            context, context.read<HomePatientCubit>().doctorList[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: context.read<HomePatientCubit>().doctorList.length,
    );
  }

  Widget buildChatCard(BuildContext context, DoctorModel model) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DoctorDetails()));
        MySharedPreferences.setString('DoctorDetailsId', model.uId!);
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
