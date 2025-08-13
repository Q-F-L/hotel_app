part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class AuthNameChanged extends AuthEvent {
  final String name;

  AuthNameChanged(this.name);
}

class AuthSurnameChanged extends AuthEvent {
  final String surname;

  AuthSurnameChanged(this.surname);
}

class AuthEmailChanged extends AuthEvent {
  final String email;

  AuthEmailChanged(this.email);

  List<Object> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  AuthPasswordChanged(this.password);
}

class AuthSubmitted extends AuthEvent {}

class AuthLogin extends AuthSubmitted {
  final String? fcmToken;

  AuthLogin({this.fcmToken});
}

class AuthRegister extends AuthSubmitted {}

class AuthCheckToken extends AuthEvent {}

class AuthLogout extends AuthEvent {}
