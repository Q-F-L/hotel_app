import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../../data/token.dart';
import '../../../data/validators.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenRepository tokenRepository;

  AuthBloc({required this.tokenRepository}) : super(AuthInitial()) {
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthNameChanged>(_onNameChanged);
    on<AuthSurnameChanged>(_onSurnameChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
    on<AuthCheckToken>(_onCheckToken);
    on<AuthLogout>(_onLogout);
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

    emit(state.copyWith(
      emailError: emailError,
      isFormValid: emailError == null,
    ));

    if (emailError != null) {
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final response = await http.post(
        Uri.parse('https://app.successhotel.ru/api/client/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': state.email,
          'password': state.password,
        }),
      );

      final json = jsonDecode(response.body);
      print(json);

      if (response.statusCode == 200 && json['success'] == true) {
        final token = json['token'] as String;
        await tokenRepository.saveToken(token);

        // Отправляем FCM токен после успешной авторизации
        if (event.fcmToken != null) {
          await _sendFcmToken(token, event.fcmToken!);
        }

        emit(state.copyWith(
          status: AuthStatus.authenticated,
          token: token,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: json['error'] ?? 'Ошибка авторизации',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Ошибка соединения',
      ));
    }
  }

  Future<void> _sendFcmToken(String authToken, String fcmToken) async {
    try {
      await http.post(
        Uri.parse('https://app.successhotel.ru/api/profile/fcm-token'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'device_token': fcmToken,
        }),
      );
    } catch (e) {
      print(e);
      // Игнорируем ошибку отправки FCM токена, так как это не критично
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

    emit(state.copyWith(status: AuthStatus.loading));

    try {
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

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 && json['success'] == true) {
        emit(state.copyWith(
          status: AuthStatus.success,
          message: json['message'],
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: json['message'] ?? 'Ошибка регистрации',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Ошибка соединения',
      ));
    }
  }

  void _onCheckToken(AuthCheckToken event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final token = await tokenRepository.getToken();

    if (token != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        token: token,
      ));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await tokenRepository.deleteToken();
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      token: null,
    ));
  }
}
