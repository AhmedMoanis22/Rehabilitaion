import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/helper/helperfunctions.dart';

import '../../../models/messgae_model.dart';
import '../../../models/patient_model.dart';
import '../../../models/user_model.dart';
import 'home_patient_state.dart';

class HomePatientCubit extends Cubit<HomePatientState> {
  HomePatientCubit() : super(HomePatientInitial());
  PatientModel? patientModel;
  List<DoctorModel> doctorList = [];
  DoctorModel? doctorModel;
  List<MessageModel> messageList = [];

  void getDataHome() async {
    emit(HomePatientLoading());

    await FirebaseFirestore.instance
        .collection('patients')
        .doc(MySharedPreferences.getString('PatientId'))
        .get()
        .then((value) async {
      patientModel = PatientModel.fromjason(value.data()!);
      print(value.data()!);

      emit(HomePatientSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(HomePatientError(error: e.toString()));
    });
  }

  void getDoctorList() async {
    emit(HomePatientLoading());

    await FirebaseFirestore.instance.collection('doctors').get().then((value) {
      for (var element in value.docs) {
        doctorList.add(DoctorModel.fromjason(element.data()));
      }

      emit(HomePatientSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(HomePatientError(error: e.toString()));
    });
  }

  void getDoctorData() async {
    emit(HomePatientDoctorDataLoading());

    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(MySharedPreferences.getString('DoctorDetailsId'))
        .get()
        .then((value) async {
      doctorModel = DoctorModel.fromjason(value.data()!);
      print(value.data()!);

      emit(HomePatientDoctorDataSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(HomePatientDoctorDataError(error: e.toString()));
    });
  }

  void sendMssageFromPatientToDoctor({
    required String receiverId,
    required String text,
    required String dateTime,
    required String senderId,
  }) {
    MessageModel model = MessageModel(
      text: text,
      datetime: dateTime,
      receiverId: receiverId,
      senderId: senderId,
    );
    FirebaseFirestore.instance
        .collection('patients')
        .doc(patientModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.tojason())
        .then((value) {
      emit(SendMessageSucess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError(error: error.toString()));
    });

    FirebaseFirestore.instance
        .collection('doctors')
        .doc(receiverId)
        .collection('chats')
        .doc(patientModel!.uId)
        .collection('messages')
        .add(model.tojason())
        .then((value) {
      emit(SendMessageSucess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError(error: error.toString()));
    });
  }

  void getPatientMessageToDoctor({required String receiverId}) async {
    FirebaseFirestore.instance
        .collection('patients')
        .doc(patientModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      messageList.clear();
      for (var element in event.docs) {
        messageList.add(MessageModel.fromjason(element.data()));
      }
      emit(GetAllMessageSucess());
    });
  }
}
