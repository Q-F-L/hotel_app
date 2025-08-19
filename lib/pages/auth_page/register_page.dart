import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/pages/auth_page/bloc/auth_bloc.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import '../../elements/text_input_form.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  void showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: MediaQuery.of(context).size.width * 0.5 - 100, // Центрирование
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.realBlack,
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: IntrinsicWidth(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.realBlack),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFB),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset('assets/images/left_arrow.png'),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FBFB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: Text(
          "Регистрация",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.failure ||
                (state.emailError != null ||
                    state.passwordError != null ||
                    state.errorName != null ||
                    state.surnameError != null)) {
              final errorMessage = state.errorMessage ??
                  state.errorName ??
                  state.surnameError ??
                  state.emailError ??
                  state.passwordError ??
                  'Произошла ошибка';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  content: Text(
                    errorMessage,
                    style: TextStyle(color: AppColors.realBlack),
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            final bloc = context.read<AuthBloc>();
            bool canClick = state.email.isNotEmpty && state.password.isNotEmpty;

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: TextInputForm(
                        prefix: Image.asset('assets/images/prefix_user.png'),
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Имя',
                        initialValue: state.name,
                        errorText: state.errorName,
                        onChanged: (value) => bloc.add(AuthNameChanged(value)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextInputForm(
                        prefix: Image.asset('assets/images/prefix_user.png'),
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Фамилия',
                        initialValue: state.surname,
                        errorText: state.surnameError,
                        onChanged: (value) =>
                            bloc.add(AuthSurnameChanged(value)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextInputForm(
                        prefix: IconGradient(icon: Icon(Icons.email), colors: [
                          AppColors.grandColorFirst,
                          AppColors.grandColorFirst,
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Введите email',
                        initialValue: state.email,
                        errorText: state.emailError,
                        onChanged: (value) => bloc.add(AuthEmailChanged(value)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextInputForm(
                        prefix: IconGradient(icon: Icon(Icons.lock), colors: [
                          AppColors.grandColorFirst,
                          AppColors.grandColorSecond,
                        ]),
                        isPassword: true,
                        hintText: 'Введите пароль',
                        initialValue: state.password,
                        errorText: state.passwordError,
                        onChanged: (value) =>
                            bloc.add(AuthPasswordChanged(value)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Нажимая сохранить я соглашаюсь с ',
                          style: Theme.of(context).textTheme.labelSmall,
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showCustomSnackBar(
                                        context, "Правилам сервис");
                                  },
                                text: 'правилами сервиса ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 27, 194, 122))),
                            TextSpan(text: 'и '),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showCustomSnackBar(
                                        context, "Политика конфидециальности");
                                  },
                                text: 'политикой конфидециальности',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 27, 194, 122))),
                          ],
                        ),
                      ),
                    ),
                    GradientButton(
                      onPressed: () => canClick ? bloc.add(AuthRegister()) : {},
                      canClick: canClick,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 40.0),
                      child: Text(
                        "Сохранить",
                        style: const TextStyle(
                          fontFamily: 'Philosopher',
                          color: Color(0xFFFEFEFF),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
