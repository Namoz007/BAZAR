sealed class AuthenticationBlocState {}

final class InitialAuthenticationBlocState extends AuthenticationBlocState {}

final class LoadingAuthenticationBlocState extends AuthenticationBlocState {}

final class AuthenticatedUserAuthenticationBlocState
    extends AuthenticationBlocState {}

final class UnAuthenticatedUserAuthenticationBlocState
    extends AuthenticationBlocState {}

final class ErrorAuthenticationBlocState extends AuthenticationBlocState {
  String message;

  ErrorAuthenticationBlocState({
    required this.message,
  });
}
