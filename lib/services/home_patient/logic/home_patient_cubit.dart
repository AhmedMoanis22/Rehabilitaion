// ignore_for_file: avoid_unnecessary_containers

import 'dart:developer';
import 'dart:io';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/helper/helperfunctions.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:video_player/video_player.dart';

import '../../../models/messgae_model.dart';
import '../../../models/patient_model.dart';
import '../../../models/user_model.dart';
import 'home_patient_state.dart';
import 'package:path/path.dart' as path;

import 'send_file_cubit.dart';

class HomePatientCubit extends Cubit<HomePatientState> {
  HomePatientCubit() : super(HomePatientInitial());
  PatientModel? patientModel;
  final TextEditingController messageController = TextEditingController();
  final FocusNode patientFocusNode = FocusNode();
  List<DoctorModel> doctorList = [];
  DoctorModel? doctorModel;
  List<MessageModel> messageList = [];
  bool isSend = true;

  ScrollController scrollController=ScrollController();

  static final Reference ref = FirebaseStorage.instance.ref("assets");

  sendMediaInChat(BuildContext context,
      {required senderId, required receiverId, required dateTime}) async {
    late FlickManager flickManager;
    String? fileName;
    File? file;

// if (result != null) {
//    file = File(result.files.single.path!);
// } else {
//   // User canceled the picker
// }
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    // final ImagePicker picker=ImagePicker();
    // final XFile? VideoPicked=await picker.pickVideo(source: ImageSource.camera,preferredCameraDevice:CameraDevice.rear );
    // if (VideoPicked != null)
    if (result != null) {
      file = File(result.files.single.path!);
      fileName =
          "${patientModel!.uId}${doctorModel!.uId}/${path.basename(result.files.single.path!)}${DateTime.now()}";

      // file=File(VideoPicked.path);
      // fileName="${patientModel!.uId}${doctorModel!.uId}/${path.basename(VideoPicked.path)}${DateTime.now()}";

      flickManager =
          FlickManager(videoPlayerController: VideoPlayerController.file(file));
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: FlickVideoPlayer(flickManager: flickManager),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: ()  {
                      BlocProvider.of<SendVideoCubit>(context).sendVideo(
                        filePath:result.files.single.path! ,
                          file: file,
                          fileName: fileName,
                          ref: ref,
                          context: context,
                          senderId: senderId,
                          receiverId: receiverId,
                          dateTime: dateTime);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: Colors.blue, // Button background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: BlocBuilder<SendVideoCubit, SendStates>(
                      builder: (context, state) {
                        return state == SendStates.init
                            ? const Text('Send')
                            : (state == SendStates.loading
                                ?  LottieBuilder.asset("assets/loading.json")
                                : (state == SendStates.failure
                                    ? const Icon(Icons.refresh,color: Colors.white,)
                                    : const Text('Send')));
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: Colors.red, // Button background color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }




scrollToDown(){


   scrollController.jumpTo(scrollController.position.maxScrollExtent);
}
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

  void sendMssageFromPatientToDoctor(
      {required String receiverId,
      required String text,
      required String dateTime,
      required String senderId,
      required String url}) {
    MessageModel model = MessageModel(
        text: text,
        datetime: dateTime,
        receiverId: receiverId,
        senderId: senderId,
        url: url);
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

    messageController.text = "";
    patientFocusNode.unfocus();
    log(doctorModel!.uId.toString());
    log(patientModel!.uId.toString());

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

    scrollToDown();
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
