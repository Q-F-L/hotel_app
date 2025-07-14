import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/pages/auth_page/bloc/auth_bloc.dart';

import '../../elements/text_input_form.dart';
import '../../themes/themes.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFB),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FBFB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: Text(
          "Авторизация",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.failure ||
                (state.emailError != null || state.passwordError != null)) {
              final errorMessage = state.errorMessage ??
                  state.emailError ??
                  state.passwordError ??
                  'Произошла ошибка';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
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
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/registration");
                          },
                          child: Text("Регистрация", style: link)),
                    ),
                    GradientButton(
                      onPressed: () => canClick ? bloc.add(AuthLogin()) : {},
                      canClick: canClick,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 40.0),
                      child: Text(
                        "Войти",
                        style: whiteTextButton,
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
