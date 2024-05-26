

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_patient_cubit.dart';
import 'package:http/http.dart' as http;

class SendVideoCubit extends Cubit<SendStates> {
  SendVideoCubit() : super(SendStates.init);



sendVideo({required String filePath,
  
  required Reference ref,File?file,String? fileName,required BuildContext context,required senderId,required receiverId,required dateTime}) async {


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
            //  modelResult(url: "<url_link>",file: file);
              
              
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









Future<void> modelResult({required String url, required File file}) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  
  var response = await request.send();
  
  if (response.statusCode == 200) {
    // Upload successful
    var responseString = await response.stream.bytesToString();
    // If the response is JSON, you can parse it like this:
    var jsonResponse = jsonDecode(responseString);
    //TODO: store to collection fire sore or shared prefrencess
    log(jsonResponse);
  } else {
    // Handle error
    var responseString = await response.stream.bytesToString();
    log('Error: $responseString');
  }
}

