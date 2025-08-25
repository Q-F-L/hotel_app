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
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
    on<AuthCheckToken>(_onCheckToken);
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    final String? emailError = Validators.validateEmail(event.email);
    print("Login");

    print("emailError $emailError");
    if (emailError != null) {
      emit(state.copyWith(
        emailError: emailError,
        isFormValid: true,
        status: AuthStatus.failure,
      ));
      return;
    }

    try {
      final LoginModel jsonModel =
          await AuthRequest.login(event.email, event.password);

      if (jsonModel.status == true) {
        final token = jsonModel.token ?? "Ошибка: Пустой токен";

        await TokenRepository.saveToken(token);

        await TokenRepository.loadToken();

        // Нужно для firbase
        await AuthRequest.sendFcmToken(token, token);

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
      print(e);
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    final passwordError = Validators.validatePassword(event.password);
    final emailError = Validators.validateEmail(event.email);
    final nameError = Validators.validateName(event.name);
    final surnameError = Validators.validateSurname(event.surname);

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
        event.name,
        event.surname,
        event.email,
        event.password,
      );

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
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Ошибка соединения',
      ));
    }
  }

  void _onCheckToken(AuthCheckToken event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    await User.create();
    if (TokenRepository.token == User.deviceToken) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        token: User.deviceToken,
      ));
      return;
    }

    if (TokenRepository.token.isNotEmpty) {
      await AuthRequest.sendFcmToken(
          TokenRepository.token, TokenRepository.token);
      await User.create();
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        token: TokenRepository.token,
      ));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }
}
