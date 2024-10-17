
import '../../../../../data/models/user_model.dart';

sealed class UserBlocState{}

final class InitialUserBlocState extends UserBlocState{}

final class LoadingUserBlocState extends UserBlocState{}

final class LoadedUserUserBlocState extends UserBlocState{
  UserDetails userModel;

  LoadedUserUserBlocState({required this.userModel,});
}

final class ErrorUserBlocState extends UserBlocState{}