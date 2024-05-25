

import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_patient_cubit.dart';

class SendVideoCubit extends Cubit<SendStates> {
  SendVideoCubit() : super(SendStates.init);



sendVideo({required Reference ref,File?file,String? fileName,required BuildContext context,required senderId,required receiverId,required dateTime}) async {


emit(SendStates.loading);

      try{  
                         // Handle send action
            await  ref.child(fileName!).putFile(file!);
              String url= await ref.child(fileName).getDownloadURL();
              log(url);

              if(!context.mounted)return;
              
            BlocProvider.of<HomePatientCubit>(context).sendMssageFromPatientToDoctor(
                text: fileName,
                senderId: senderId,
                receiverId: receiverId,
                dateTime: dateTime,
                url:url
              );

                 emit(SendStates.success);
              if (context.mounted) Navigator.of(context).pop();
              
              
}catch(e){
  emit(SendStates.failure);
log('Error uploading file: $e');
}



}


}














enum SendStates{

init,
loading,
success,
failure,


}