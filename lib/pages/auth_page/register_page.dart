import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/pages/auth_page/bloc/auth_bloc.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

import '../../elements/text_input_form.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _canClick = false;

  void _wireCanClick() {
    setState(() {
      _canClick = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _surnameController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    // Только для UI-активации кнопки — НЕ диспатчим в BLoC
    _nameController.addListener(_wireCanClick);
    _surnameController.addListener(_wireCanClick);
    _emailController.addListener(_wireCanClick);
    _passwordController.addListener(_wireCanClick);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
        title:
            Text("Регистрация", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.failure ||
                state.errorName != null ||
                state.surnameError != null ||
                state.emailError != null ||
                state.passwordError != null) {
              final errorMessage = state.errorMessage ??
                  state.errorName ??
                  state.surnameError ??
                  state.emailError ??
                  state.passwordError ??
                  'Произошла ошибка';
              showToast(context, errorMessage);
            }
            if (state.status == AuthStatus.success) Navigator.pop(context);
          },
          builder: (context, state) {
            final bloc = context.read<AuthBloc>();

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: ListView(
                  children: [
                    const SizedBox(height: 30),
                    TextInputForm(
                      controller: _nameController,
                      prefix: Image.asset('assets/images/prefix_user.png'),
                      keyboardType: TextInputType.text,
                      hintText: 'Имя',
                      errorText: state.errorName,
                    ),
                    const SizedBox(height: 20),
                    TextInputForm(
                      controller: _surnameController,
                      prefix: Image.asset('assets/images/prefix_user.png'),
                      keyboardType: TextInputType.text,
                      hintText: 'Фамилия',
                      errorText: state.surnameError,
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    // ... твой RichText с политиками ...
                    const SizedBox(height: 20),
                    GradientButton(
                      onPressed: () => _canClick
                          ? {
                              bloc.add(AuthRegister(
                                name: _nameController.text,
                                surname: _surnameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              )),
                              if (state.message != null)
                                showToast(context, state.message!),
                            }
                          : {showToast(context, "Заполните данные!")},
                      canClick: _canClick,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 40),
                      child: const Text(
                        "Сохранить",
                        style: TextStyle(
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
