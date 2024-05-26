
import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'package:graduationnn/models/messgae_model.dart';

import '../../../services/home_patient/logic/home_patient_cubit.dart';
import '../../../services/home_patient/logic/home_patient_state.dart';
import '../../widgets/video_player.dart';

class ChatPatientScreen extends StatefulWidget {
  const ChatPatientScreen({super.key});

  @override
  State<ChatPatientScreen> createState() => _ChatPatientScreenState();
}

class _ChatPatientScreenState extends State<ChatPatientScreen> {
 
 
  @override
  void initState() {
    context.read<HomePatientCubit>().getDataHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      context.watch<HomePatientCubit>().getPatientMessageToDoctor(
          receiverId: context.watch<HomePatientCubit>().doctorModel!.uId!);
      return BlocBuilder<HomePatientCubit, HomePatientState>(
        builder: (context, state) {
          if (state is HomePatientDoctorDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(children: [
                CircleAvatar(
                  radius: 20.0,
                  child: Image.network(
                    '${context.read<HomePatientCubit>().doctorModel!.image}',
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text('${context.read<HomePatientCubit>().doctorModel!.name}'),
              ]),
              centerTitle: true,
            ),
            body: context.watch<HomePatientCubit>().messageList.isNotEmpty
                ? Column(children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: context
                                  .read<HomePatientCubit>().scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (context
                                  .read<HomePatientCubit>()
                                  .patientModel!
                                  .uId ==
                              context
                                  .read<HomePatientCubit>()
                                  .messageList[index]
                                  .senderId) {
                            return doctorMessage(
                                context.read<HomePatientCubit>().messageList,
                                index);
                          }

                          return patientMessage(
                              context.read<HomePatientCubit>().messageList,
                              index);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20.0),
                        itemCount:
                            context.read<HomePatientCubit>().messageList.length,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(children: [
                            InkWell(onTap: () {
                              context
                                      .read<HomePatientCubit>()
                                      .sendMediaInChat(context, senderId: context
                                              .read<HomePatientCubit>()
                                              .patientModel!
                                              .uId!,
                                          receiverId: context
                                              .read<HomePatientCubit>()
                                              .doctorModel!
                                              .uId!, dateTime: DateTime.now().toString(),);
                            },
                              child: Container(padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset("assets/attach.png",width: 30,height: 30,)),
                            ),
                          Expanded(
                            child: TextFormField(
                                controller:  context
                                    .read<HomePatientCubit>()
                                    .messageController,
                                decoration: const InputDecoration(
                                  hintText: 'Type your message',
                                  border: InputBorder.none,
                                )),
                          ),
                          Container(
                            width: 60,
                            height: 50,
                            color: Colors.blue.shade400,
                            child: MaterialButton(
                              onPressed: () {
                                context
                                    .read<HomePatientCubit>()
                                    .sendMssageFromPatientToDoctor(url: "",
                                        senderId: context
                                            .read<HomePatientCubit>()
                                            .patientModel!
                                            .uId!,
                                        receiverId: context
                                            .read<HomePatientCubit>()
                                            .doctorModel!
                                            .uId!,
                                        text:  context
                                    .read<HomePatientCubit>()
                                    .messageController.text,
                                        dateTime: DateTime.now().toString());
                              },
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No messages yet',
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          child: Row(children: [
                            InkWell(onTap: () {
                              context
                                      .read<HomePatientCubit>()
                                      .sendMediaInChat(context, senderId: context
                                              .read<HomePatientCubit>()
                                              .patientModel!
                                              .uId!,
                                          receiverId: context
                                              .read<HomePatientCubit>()
                                              .doctorModel!
                                              .uId!, dateTime: DateTime.now().toString(),);
                            },
                              child: Container(padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset("assets/attach.png",width: 30,height: 30,)),
                            ),
                            Expanded(
                              child: TextFormField(
                                focusNode:  context
                                      .read<HomePatientCubit>()
                                      .patientFocusNode,
                                  controller:  context
                                    .read<HomePatientCubit>()
                                    .messageController,
                                  decoration: const InputDecoration(
                                    hintText: 'Type your message',
                                    border: InputBorder.none,
                                  )),
                            ),
                                // TODO:implement media icon here  

                            Container(
                              width: 60,
                              height: 50,
                              color: Colors.blue.shade400,
                              child: MaterialButton(
                                onPressed: () {
                                  context
                                      .read<HomePatientCubit>()
                                      .sendMssageFromPatientToDoctor(url: "",
                                          senderId: context
                                              .read<HomePatientCubit>()
                                              .patientModel!
                                              .uId!,
                                          receiverId: context
                                              .read<HomePatientCubit>()
                                              .doctorModel!
                                              .uId!,
                                          text:  context
                                    .read<HomePatientCubit>()
                                    .messageController.text,
                                          dateTime: DateTime.now().toString());







                                          
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ]),
          );
        },
      );
    });
  }

  Widget patientMessage(List<MessageModel> message, index) {
    // TODO:implement condition here and then network image 
    String? msgText=message[index].text;
    String? url= message[index].url;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
           child:url==""? Text(
             msgText!,
            ):VideoPlayerWidget(videoUrl: url!,),
          ),
        ),
      ),
    );
  }

  Widget doctorMessage(List<MessageModel> message, index) {
    // TODO:implement condition here and then network image 
    String? msgText=message[index].text;
    String? url= message[index].url;

  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade200,
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child:url==""? Text(
             msgText!,
            ):VideoPlayerWidget(videoUrl: url!,),
          ),
        ),
      ),
    );
  }
}
