import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationnn/models/messgae_model.dart';

import '../../../services/home_doctor/logic/home_doctor_cubit.dart';
import '../../../services/home_doctor/logic/home_doctor_state.dart';

class ChatDocotorScreen extends StatelessWidget {
  ChatDocotorScreen({super.key});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeDoctorCubit()
        ..getDataHome()
        ..getPatientData(),
      child: Builder(builder: (BuildContext context) {
        context.watch<HomeDoctorCubit>().getDoctorMessageToPatient(
            receiverId: context.watch<HomeDoctorCubit>().patientModel!.uId!);
        return BlocBuilder<HomeDoctorCubit, HomeDoctorState>(
          builder: (context, state) {
            if (state is HomeDoctorPatientDataLoading ||
                context.read<HomeDoctorCubit>().patientModel == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(children: [
                  CircleAvatar(
                    radius: 20.0,
                    child: Image.network(
                      '${context.watch<HomeDoctorCubit>().patientModel!.image}',
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                      '${context.watch<HomeDoctorCubit>().patientModel!.name}'),
                ]),
                centerTitle: true,
              ),
              body: context.read<HomeDoctorCubit>().messageList.isNotEmpty
                  ? Column(children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (context
                                    .read<HomeDoctorCubit>()
                                    .doctorModel!
                                    .uId ==
                                context
                                    .read<HomeDoctorCubit>()
                                    .messageList[index]
                                    .senderId) {
                              return doctorMessage(
                                  context.watch<HomeDoctorCubit>().messageList,
                                  index);
                            }

                            return patientMessage(
                                context.watch<HomeDoctorCubit>().messageList,
                                index);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20.0),
                          itemCount: context
                              .watch<HomeDoctorCubit>()
                              .messageList
                              .length,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Spacer(),
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
                            Expanded(
                              child: TextFormField(
                                  controller: messageController,
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
                                      .read<HomeDoctorCubit>()
                                      .sendMssageFromDoctorToPatient(
                                          senderId: context
                                              .read<HomeDoctorCubit>()
                                              .doctorModel!
                                              .uId!,
                                          receiverId: context
                                              .read<HomeDoctorCubit>()
                                              .patientModel!
                                              .uId!,
                                          text: messageController.text,
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
                              Expanded(
                                child: TextFormField(
                                    controller: messageController,
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
                                        .read<HomeDoctorCubit>()
                                        .sendMssageFromDoctorToPatient(
                                            senderId: context
                                                .read<HomeDoctorCubit>()
                                                .doctorModel!
                                                .uId!,
                                            receiverId: context
                                                .read<HomeDoctorCubit>()
                                                .patientModel!
                                                .uId!,
                                            text: messageController.text,
                                            dateTime:
                                                DateTime.now().toString());
                                    void dispose() {
                                      messageController.clear();
                                    }
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
      }),
    );
  }

  Widget patientMessage(List<MessageModel> message, index) {
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
            child: Text(
              '${message[index].text}',
            ),
          ),
        ),
      ),
    );
  }

  Widget doctorMessage(List<MessageModel> message, index) {
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
            child: Text(
              '${message[index].text}',
            ),
          ),
        ),
      ),
    );
  }
}
