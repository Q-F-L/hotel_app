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

    on<AuthClearStatus>((event, emit) {
      emit(state.copyWith(
          status: AuthStatus.initial, errorMessage: null, message: null));
    });
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));
    final String? errorMessage = Validators.validateEmail(event.email);

    if (errorMessage != null) {
      emit(state.copyWith(
        errorMessage: errorMessage,
        status: AuthStatus.failure,
      ));
      return;
    }

    try {
      final LoginModel jsonModel =
          await AuthRequest.login(event.email, event.password);

      if (jsonModel.status == true && (jsonModel.token ?? '').isNotEmpty) {
        final token = jsonModel.token;

        await TokenRepository.saveToken(token!);

        await TokenRepository.loadToken();

        // Нужно для firbase
        await AuthRequest.sendFcmToken(authToken: token, fcmToken: token);

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
        errorMessage: e.toString(),
      ));
    }
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    final passwordError = Validators.validatePassword(event.password);
    final emailError = Validators.validateEmail(event.email);
    final nameError = Validators.validateName(event.name);
    final surnameError = Validators.validateSurname(event.surname);
    final errorMessage =
        nameError ?? surnameError ?? emailError ?? passwordError;

    emit(state.copyWith(
      status: AuthStatus.failure,
      errorMessage: errorMessage,
    ));

    if (errorMessage != null) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: errorMessage,
      ));
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

    if (TokenRepository.token.isNotEmpty) {
      await AuthRequest.sendFcmToken(
          authToken: TokenRepository.token, fcmToken: TokenRepository.token);

      ///TODO не отправлять bearer token вместо divice token
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
