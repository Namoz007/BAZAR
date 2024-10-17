import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/dio_network.dart';
import '../../core/utils/details/app_details.dart';
import '../../core/utils/helpers/dependency_helpers.dart';
import '../../domain/entities/login_request_model.dart';
import '../../domain/entities/register_request_model.dart';
import '../models/user_model.dart';

class AuthenticationSources {
  final _dio = DioFile.getInstance().dio;

  Future<bool> getUser() async {
    final users = await _dio.get("/users.json");
    if (users.data != null) {
      final mp = users.data as Map<String, dynamic>;
      for (int i = 0; i < mp.keys.toList().length; i++) {
        if (mp[mp.keys.toList()[i]]['email'] == getIt<SharedPreferences>().getString("email")) {
          AppDetails.model = UserDetails.fromJson(mp[mp.keys.toList()[i]]);
          return true;
        }
      }
    }
    return false;
  }

  Future<String?> loginUser(LoginRequestModel model) async {
    try {
      final data = await getIt<FirebaseAuth>().signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      getIt<SharedPreferences>().setString("email", model.email);
    } catch (e) {
      return "E-mail or password is incorrect!";
    }
  }

  Future<String?> registerUser(RegisterRequestModel model) async {
    try {
      await getIt<FirebaseAuth>().createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      final response = await _dio.post("/users.json",data: {
        "email": model.email,
        "fullName": model.fullName,
        "id": '',
      },);
      await _dio.patch("/users/${response.data['name']}.json",data: {
        'id':response.data['name']
      },);

      AppDetails.model = UserDetails(id: response.data['name'], fullName: model.fullName, email: model.email,);
      return null;
    } catch (e) {
      return 'User already exists!';
    }
  }

  Future<void> resetPasswordForEmail(String email) async {
    getIt<FirebaseAuth>().sendPasswordResetEmail(email: email);
  }
}
