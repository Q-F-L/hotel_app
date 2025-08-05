import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/pages/auth_page/bloc/auth_bloc.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import '../../data/token.dart';
import '../../elements/text_input_form.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      width: min(message.length * 13, MediaQuery.of(context).size.width * 0.8),
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(162, 59, 59, 59),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(6),
          color: AppColors.white,
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        create: (context) => AuthBloc(tokenRepository: TokenRepository()),
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
              showSnackBar(context, errorMessage);
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
                          Color.fromARGB(255, 83, 232, 140),
                          Color.fromARGB(255, 21, 190, 120),
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
                          Color.fromARGB(255, 83, 232, 140),
                          Color.fromARGB(255, 21, 190, 120),
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
                                    showSnackBar(context, "Правилам сервис");
                                  },
                                text: 'правилами сервиса ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 27, 194, 122))),
                            TextSpan(text: 'и '),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showSnackBar(
                                        context, 'Политикой конфидециальности');
                                  },
                                text: 'политикой конфидециальности',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 27, 194, 122))),
                          ],
                        ),
                      ),
                    ),
                    GradientButton(
                      onPressed: () => canClick
                          ? {
                              bloc.add(AuthRegister()),
                              showSnackBar(context, state.message ?? ''),
                            }
                          : {},
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
