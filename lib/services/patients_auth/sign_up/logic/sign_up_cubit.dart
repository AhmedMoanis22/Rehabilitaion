import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/models/patient_model.dart';

import 'sign_up_state.dart';

class SignUpPatientCubit extends Cubit<SignUpPatientState> {
  SignUpPatientCubit() : super(SignUpInitial());

  void createPatientAccount({
    required String name,
    required String phone,
    required String email,
    required String password,
    required int age,
  }) {
    print('kkkkk');
    emit(SignUpLoading());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreatePatient(
          email: email,
          name: name,
          phone: phone,
          password: password,
          age: age,
          uId: value.user!.uid);

      emit(SignUpSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(SignUpError(error: e.toString()));
    });
  }

  void userCreatePatient({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String uId,
    required int age,
  }) {
    PatientModel model = PatientModel(
        name: name,
        phone: phone,
        email: email,
        password: password,
        uId: uId,
        image: 'https://m.media-amazon.com/images/I/41jLBhDISxL._SY355_.jpg',
        age: age);

    FirebaseFirestore.instance
        .collection('patients')
        .doc(uId)
        .set(model.toJason())
        .then((value) {
      emit(CreateUserPatientSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(CreateUserPatientError(error: e.toString()));
    });
  }
}
