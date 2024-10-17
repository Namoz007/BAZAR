import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/details/app_details.dart';
import '../../../../core/utils/helpers/dependency_helpers.dart';
import '../../../../data/repostories/authentication_repositories.dart';
import 'authentication_bloc_event.dart';
import 'authentication_bloc_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  final _repositories = getIt<AuthenticationRepositories>();

  AuthenticationBloc() :
        super(InitialAuthenticationBlocState()) {
    on<LoggedUserAuthenticationBlocEvent>(_userLogged);
    on<SignUpUserAuthenticationBlocEvent>(_registerUser);
    on<LoginUserAuthenticationBlocEvent>(_loginUser);
    on<ResetPasswordUserAuthenticationBlocEvent>(_resetPassword);
    on<LogOutAuthenticationBlocEvent>(_logOut);
  }

  void _logOut(LogOutAuthenticationBlocEvent event,emit){
    getIt<SharedPreferences>().remove("email");
    AppDetails.model = null;
  }

  void _loginUser(LoginUserAuthenticationBlocEvent event,emit) async{
    emit(LoadingAuthenticationBlocState());
    final response = await _repositories.loginUser(event.model);
    if(response == null){
      final userdata = await _repositories.getUser();
      if(userdata){
        emit(AuthenticatedUserAuthenticationBlocState());
      }else{
        emit(ErrorAuthenticationBlocState(message: "Something went wrong!"));
      }
    }else{
      emit(ErrorAuthenticationBlocState(message: response));
    }
  }

  void _resetPassword(ResetPasswordUserAuthenticationBlocEvent event,emit) async{
    emit(LoadingAuthenticationBlocState());
    _repositories.resetPasswordForEmail(event.email);
    emit(ErrorAuthenticationBlocState(message: "Message has been sent to your email"));
  }

  void _userLogged(LoggedUserAuthenticationBlocEvent event,emit) async{
    emit(LoadingAuthenticationBlocState());
    final response = await _repositories.userLogged();
    if(response){
      await _repositories.getUser();
      emit(AuthenticatedUserAuthenticationBlocState());
    }else{
      emit(UnAuthenticatedUserAuthenticationBlocState());
    }
  }

  void _registerUser(SignUpUserAuthenticationBlocEvent event,emit) async{
    emit(LoadingAuthenticationBlocState());
    final reponse = await _repositories.registerUser(event.model);
    if(reponse == null){
      emit(AuthenticatedUserAuthenticationBlocState());
    }else{
      emit(ErrorAuthenticationBlocState(message: reponse));
    }
  }
}
