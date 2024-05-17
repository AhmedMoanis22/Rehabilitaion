import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import 'sign_up_state.dart';

class SignUpCubitDoctor extends Cubit<SignUpDoctorState> {
  SignUpCubitDoctor() : super(SignUpInitial());

  void createAccount(
      {required String name,
      required String phone,
      required String email,
      required String password,
      required int age,
      required String specialization}) {
    print('kkkkk');
    emit(SignUpLoading());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        password: password,
        age: age,
        uId: value.user!.uid,
        specialization: specialization,
      );

      emit(SignUpSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(SignUpError(error: e.toString()));
    });
  }

  void userCreate(
      {required String name,
      required String phone,
      required String email,
      required String password,
      required String uId,
      required int age,
      required String specialization}) {
    DoctorModel model = DoctorModel(
        name: name,
        phone: phone,
        email: email,
        password: password,
        uId: uId,
        image:
            'https://cdn3d.iconscout.com/3d/premium/thumb/doctor-avatar-10107433-8179550.png?f=webp',
        specialization: specialization,
        age: age);

    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uId)
        .set(model.toJason())
        .then((value) {
      emit(CretaeUserSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(CretaeUserFaluire(error: e.toString()));
    });
  }
}
