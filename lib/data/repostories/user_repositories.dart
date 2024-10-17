import 'dart:io';

import '../../core/utils/helpers/dependency_helpers.dart';
import '../datasources/user_sources.dart';
import '../models/user_model.dart';


class UserRepositories{
  final _sources = getIt<UserSources>();


  Future<UserDetails> getMyUser() async{
    return await _sources.getMyUser();
  }

  Future<UserDetails> editUser(UserDetails model,File? file) async{
    return await _sources.editUserDetails(model,file);
  }

}