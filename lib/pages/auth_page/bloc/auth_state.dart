part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isFormValid;
  final AuthStatus status;
  final String? errorMessage;
  final String name;
  final String? errorName;
  final String surname;
  final String? surnameError;
  final bool? isNotEmpty;
  final String? message;

  AuthState({
    this.message,
    this.isNotEmpty,
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isFormValid = false,
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.name = '',
    this.errorName,
    this.surname = '',
    this.surnameError,
  });

  AuthState copyWith({
    bool? isNotEmpty,
    String? email,
    String? name,
    String? surname,
    String? errorName,
    String? surnameError,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isFormValid,
    AuthStatus? status,
    String? errorMessage,
    String? message,
  }) {
    return AuthState(
      isNotEmpty: isNotEmpty ?? this.isNotEmpty,
      name: name ?? this.name,
      errorName: errorName ?? this.errorName,
      surnameError: surnameError ?? this.surnameError,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
    );
  }
}

class AuthInitial extends AuthState {}
