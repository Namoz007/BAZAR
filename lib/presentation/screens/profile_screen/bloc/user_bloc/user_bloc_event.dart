import 'dart:io';

import '../../../../../data/models/user_model.dart';


sealed class UserBlocEvent {}

final class GetMyUserUserBlocEvent extends UserBlocEvent {}

final class GetMyUserFromSourcesUserBlocEvent extends UserBlocEvent {}

final class EditUserBlocEvent extends UserBlocEvent {
  UserDetails model;
  File? file;

  EditUserBlocEvent({
    required this.model,
    this.file,
  });
}
