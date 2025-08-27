import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/pages/auth_page/bloc/auth_bloc.dart';
import 'package:m_softer_test_project/pages/select_hotel_page/select_hotel.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

import '../../elements/text_input_form.dart';
import '../../themes/themes.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _canClick = false;

  void _wireCanClick() {
    setState(() {
      _canClick = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_wireCanClick);
    _passwordController.addListener(_wireCanClick);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FBFB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title:
            Text("Авторизация", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.failure ||
                state.emailError != null ||
                state.passwordError != null) {
              final errorMessage = state.errorMessage ??
                  state.emailError ??
                  state.passwordError ??
                  'Произошла ошибка';
              showToast(context, errorMessage);
            }

            if (state.status == AuthStatus.authenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SelectHomePage()),
              );
            }
          },
          builder: (context, state) {
            final bloc = context.read<AuthBloc>();

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    TextInputForm(
                      controller: _emailController,
                      prefix: IconGradient(icon: Icon(Icons.email), colors: [
                        Color.fromARGB(255, 83, 232, 140),
                        Color.fromARGB(255, 21, 190, 120),
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Введите email',
                      errorText: state.emailError,
                    ),
                    const SizedBox(height: 20),
                    TextInputForm(
                      controller: _passwordController,
                      prefix: IconGradient(icon: Icon(Icons.lock), colors: [
                        Color.fromARGB(255, 83, 232, 140),
                        Color.fromARGB(255, 21, 190, 120),
                      ]),
                      isPassword: true,
                      hintText: 'Введите пароль',
                      errorText: state.passwordError,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/registration"),
                        child: Text("Регистрация", style: link),
                      ),
                    ),
                    GradientButton(
                      canClick: _canClick,
                      onPressed: () => _canClick
                          ? {
                              bloc.add(AuthLogin(
                                email: _emailController.text,
                                password: _passwordController.text,
                              )),
                            }
                          : {showToast(context, "Заполните данные")},
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 40.0),
                      child: state.status == AuthStatus.loading
                          ? CircularProgressIndicator(strokeWidth: 2)
                          : Text("Войти", style: whiteTextButton),
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
