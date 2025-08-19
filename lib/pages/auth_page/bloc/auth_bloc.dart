import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/auth/models/registration_model.dart';
import 'package:m_softer_test_project/data/auth/requests.dart';
import 'package:m_softer_test_project/data/auth/models/login_model.dart';
import 'package:m_softer_test_project/data/user/models/user.dart';
import '../../../data/token.dart';
import '../../../utils/validators.dart';

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
    on<AuthCheckToken>(_onCheckToken);
    on<AuthLogout>(_onLogout);
  }

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
      final LoginModel jsonModel =
          await AuthRequest.login(state.email, state.password);
      if (jsonModel.status == true) {
        String token = jsonModel.token ?? "Ошибка: Пустой токен";
        await TokenRepository.saveToken(token);

        // Отправляем FCM токен после успешной авторизации
        if (event.fcmToken != null) {
          await AuthRequest.sendFcmToken(token, event.fcmToken!);
        }

        emit(state.copyWith(
          status: AuthStatus.authenticated,
          token: token,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: jsonModel.error ?? 'Ошибка авторизации',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Ошибка соединения',
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

    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final RegistrationModel json = await AuthRequest.registration(
          state.name, state.surname, state.email, state.password);

      if (json.success == true) {
        emit(state.copyWith(
          status: AuthStatus.success,
          message: json.message,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.failure,
          errorMessage: json.error ?? 'Ошибка регистрации',
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
    await User.create();
    if (User.deviceToken != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        token: User.deviceToken,
      ));
      return;
    }

    if (TokenRepository.token.isNotEmpty) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        token: TokenRepository.token,
      ));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await TokenRepository.deleteToken();
    User.clear;
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      token: null,
    ));
  }
}
