import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginPatientCubit extends Cubit<LoginPatientState> {
  LoginPatientCubit() : super(LoginInitial());

  void loginPatientAccount({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccess(uId: value.user!.uid));
    }).catchError((error) {
      print(error.toString());

      emit(LoginError(error: error.toString()));
    });
  }
}
