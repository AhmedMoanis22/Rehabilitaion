import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/config/dimens.dart';
import 'package:graduationnn/config/palette.dart';
import 'package:graduationnn/view/screens/doctor/patients_screen.dart';
import 'package:graduationnn/view/screens/doctor/view_medical_history_screen.dart';
import 'package:graduationnn/view/widgets/custom_text_style.dart';

import '../../../services/database.dart';
import '../../../services/home_doctor/logic/home_doctor_cubit.dart';
import '../../../services/home_doctor/logic/home_doctor_state.dart';

class HomeDoctorScreen extends StatefulWidget {
  const HomeDoctorScreen({super.key});

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  bool? isChecked = false;

  final databaseMethods = DatabaseMethods();

  final fireStore = FirebaseFirestore.instance;
  final String collectionPatients = 'patients';
  final String collectionDoctors = 'doctors';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeDoctorCubit()..getDataHome(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeDoctorCubit, HomeDoctorState>(
              builder: (context, state) {
            if (state is HomeDoctorLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
              width: Dimens.screenWidth(context),
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome ${context.read<HomeDoctorCubit>().doctorModel!.name}',
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PatientsScreen()));
                            },
                            child: Container(
                              width: 150,
                              height: 160,
                              decoration: BoxDecoration(
                                  color: Palette.colorPrimary600,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                  child: Text(
                                'Patient’s',
                                style: txtCon(),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ViewMedicalHistoryScreen()));
                            },
                            child: Container(
                              width: 150,
                              height: 160,
                              decoration: BoxDecoration(
                                  color: Palette.colorPrimary600,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                  child: Text(
                                'View Medical History',
                                textAlign: TextAlign.center,
                                style: txtCon(),
                              )),
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
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              height: 160,
                              decoration: BoxDecoration(
                                  color: Palette.colorPrimary600,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: Text(
                                  'Start chat with Patient’s',
                                  textAlign: TextAlign.center,
                                  style: txtCon(),
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
          }),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //
        //   },
        //   backgroundColor: Palette.colorPrimary600,
        //   child: Icon(Icons.add, color: Colors.white,),
        // ),
      ),
    );
  }

// Widget doctorData(dynamic data){
//   return ListView.builder(
//       itemCount: data.docs.length,
//       itemBuilder: (context, index){
//         return GestureDetector(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDoctorScreen(user: _currentUser, patient: data.docs[index]['username'].toString(),)));
//           },
//           child: ListTile(
//             title: Text('${data.docs[index]['username'].toString().toUpperCase()}', style: txtTitle(),),
//             subtitle: Text('${data.docs[index]['email']}'),
//           ),
//         );
//       });
// }
}
