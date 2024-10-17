import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/helpers/dependency_helpers.dart';
import '../../domain/entities/login_request_model.dart';
import '../../domain/entities/register_request_model.dart';
import '../datasources/authentication_sources.dart';

class AuthenticationRepositories {
  final _services =  getIt<AuthenticationSources>();


  Future<bool> userLogged() async{
    return getIt<SharedPreferences>().getString('email') != null;
  }

  Future<bool> getUser() async{
    return await _services.getUser();
  }

  Future<String?> loginUser(LoginRequestModel model) async{
    return await _services.loginUser(model);
  }

  Future<String?> registerUser(RegisterRequestModel model) async{
    return await _services.registerUser(model);
  }

  Future<void> resetPasswordForEmail(String email) async{
    _services.resetPasswordForEmail(email);
  }
}
