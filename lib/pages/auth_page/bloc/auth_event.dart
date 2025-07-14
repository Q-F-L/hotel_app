part of 'auth_bloc.dart';

abstract class AuthEvent {}

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
}

class AuthPasswordChanged extends AuthEvent {
  final String password;

  AuthPasswordChanged(this.password);
}

class AuthSubmitted extends AuthEvent {}

class AuthLogin extends AuthSubmitted {}

class AuthRegister extends AuthSubmitted {}
