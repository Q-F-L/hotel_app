import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../../data/validators.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthNameChanged>(_onNameChanged);
    on<AuthSurnameChanged>(_onSurnameChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
  }

  bool canClick = false;

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      email: event.email,
      emailError: null,
    ));
  }

  void _onNameChanged(AuthNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      name: event.name,
      errorName: null,
    ));
  }

  void _onSurnameChanged(AuthSurnameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      surname: event.surname,
      surnameError: null,
    ));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      password: event.password,
      passwordError: null,
    ));
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final emailError = Validators.validateEmail(state.email);
    final passwordError = Validators.validatePassword(state.password);

    emit(state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
      isFormValid: emailError == null && passwordError == null,
    ));

    if (emailError != null || passwordError != null) {
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));

    try {
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Ошибка авторизации',
      ));
    }
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    final passwordError = Validators.validatePassword(state.password);
    final emailError = Validators.validateEmail(state.email);
    final nameError = Validators.validateName(state.name);
    final surnameError = Validators.validateSurname(state.surname);

    emit(state.copyWith(
      errorName: nameError,
      surnameError: surnameError,
      emailError: emailError,
      passwordError: passwordError,
      isFormValid: emailError == null &&
          passwordError == null &&
          nameError == null &&
          surnameError == null,
    ));

    if (emailError != null ||
        passwordError != null ||
        nameError != null ||
        surnameError != null) {
      return;
    }

    final response = await http.post(
      Uri.parse('https://app.successhotel.ru/api/client/register'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': state.name,
        'lastName': state.surname,
        'email': state.email,
        'password': state.password,
        'confirmPassword': state.password,
        'guard': 'client',
      }),
    );

    emit(state.copyWith(status: AuthStatus.loading));

    if (response.statusCode == 200) {
      try {
        emit(state.copyWith(status: AuthStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Ошибка авторизации',
        ));
      }
    }
  }
}
