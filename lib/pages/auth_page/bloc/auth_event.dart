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

class AuthRegister extends AuthEvent {
  final String name;
  final String surname;
  final String email;
  final String password;
  const AuthRegister({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  final String? fcmToken;
  const AuthLogin({required this.email, required this.password, this.fcmToken});
}

class AuthCheckToken extends AuthEvent {}

class AuthLogout extends AuthEvent {}
