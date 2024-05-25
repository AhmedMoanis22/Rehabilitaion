import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/helper/helperfunctions.dart';
import 'package:graduationnn/models/user_model.dart';

import '../../../models/messgae_model.dart';
import '../../../models/patient_model.dart';
import 'home_doctor_state.dart';

class HomeDoctorCubit extends Cubit<HomeDoctorState> {
  HomeDoctorCubit() : super(HomeDoctorInitial());
  DoctorModel? doctorModel;
  List<PatientModel> patientList = [];
    final TextEditingController messageController = TextEditingController();
       final FocusNode  doctorFocusNode =FocusNode();

  PatientModel? patientModel;
  List<MessageModel> messageList = [];

  ScrollController scrollController=ScrollController();







  scrollToDown(){


   scrollController.jumpTo(scrollController.position.maxScrollExtent);
}

  void getDataHome() async {
    emit(HomeDoctorLoading());

    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(MySharedPreferences.getString('DoctorId'))
        .get()
        .then((value) async {
      doctorModel = DoctorModel.fromjason(value.data()!);
      print(value.data()!);

      emit(HomeDoctorSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(HomeDoctorError(error: e.toString()));
    });
  }

  void getPatientList() async {
    emit(GetPatientListLoading());

    await FirebaseFirestore.instance.collection('patients').get().then((value) {
      for (var element in value.docs) {
        patientList.add(PatientModel.fromjason(element.data()));
      }

      emit(GetPatientListSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(GetPatientListError(error: e.toString()));
    });
  }

  void getPatientData() async {
    emit(HomeDoctorPatientDataLoading());

    await FirebaseFirestore.instance
        .collection('patients')
        .doc(MySharedPreferences.getString('PatientDetailsId'))
        .get()
        .then((value) async {
      patientModel = PatientModel.fromjason(value.data()!);
      MySharedPreferences.setString('PatientId', patientModel!.uId!);
      print(value.data()!);

      emit(HomeDoctorPatientDataSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(HomeDoctorPatientDataError(error: e.toString()));
    });
  }

  void sendMssageFromDoctorToPatient({
    required String receiverId,
    required String text,
    required String dateTime,
    required String senderId,
    required String url

  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      datetime: dateTime,
      receiverId: receiverId,
      senderId: senderId,
      url: url
    );

    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.tojason())
        .then((value) {
      emit(SendMessageSucess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError(error: error.toString()));
    });

        messageController.text="";
        doctorFocusNode.unfocus();


    FirebaseFirestore.instance
        .collection('patients')
        .doc(receiverId)
        .collection('chats')
        .doc(doctorModel!.uId)
        .collection('messages')
        .add(messageModel.tojason())
        .then((value) {
      emit(SendMessageSucess());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageError(error: error.toString()));
    });

    scrollToDown();
  }

  void getDoctorMessageToPatient({required String receiverId}) async {
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorModel!.uId)
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
