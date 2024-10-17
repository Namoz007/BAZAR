
import '../../../../domain/entities/login_request_model.dart';
import '../../../../domain/entities/register_request_model.dart';

sealed class AuthenticationBlocEvent {}

final class LoggedUserAuthenticationBlocEvent extends AuthenticationBlocEvent {}

final class LoginUserAuthenticationBlocEvent extends AuthenticationBlocEvent {
  LoginRequestModel model;

  LoginUserAuthenticationBlocEvent({
    required this.model,
  });
}

final class SignUpUserAuthenticationBlocEvent extends AuthenticationBlocEvent {
  RegisterRequestModel model;

  SignUpUserAuthenticationBlocEvent({
    required this.model,
  });
}

final class ResetPasswordUserAuthenticationBlocEvent
    extends AuthenticationBlocEvent {
  String email;

  ResetPasswordUserAuthenticationBlocEvent({
    required this.email,
  });
}

final class LogOutAuthenticationBlocEvent extends AuthenticationBlocEvent{}
