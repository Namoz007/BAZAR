import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

import '../../core/network/dio_network.dart';
import '../../core/utils/details/app_details.dart';
import '../models/user_model.dart';

class UserSources{
  final _dio = DioFile.getInstance().dio;
  final storageRef = FirebaseStorage.instance.ref();

  Future<UserDetails> getMyUser() async{
    final response = await _dio.get("/users/${AppDetails.model!.id}.json");
    final mp = response.data as Map<String,dynamic>;
    return UserDetails.fromJson(response.data);
  }
  
  Future<UserDetails> editUserDetails(UserDetails model,File? file) async{
    if(file != null){
      try {
        Reference storageRef = FirebaseStorage.instance.ref().child('${model.fullName}${Random().nextInt(99999)}_avatar.jpg');
        UploadTask uploadTask = storageRef.putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();
        model.imgUrl = downloadURL;
      } catch (e) {
        print("bu xato $e");
      }
    }

    await _dio.put("/users/${model.id}.json",data: model.toMap(),);
    return model;
  }
}