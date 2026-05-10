import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/pages/auth_page/bloc/auth_bloc.dart';
import 'package:m_softer_test_project/themes/themes.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

import '../../elements/text_input_form.dart';
import 'auth_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with WidgetsBindingObserver {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              showToast(context, state.message ?? "Пустое сообщение",
                  focus: WidgetsBinding.instance.window.viewInsets.bottom > 0);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => AuthPage()),
                ModalRoute.withName('/'),
              );
              context.read<AuthBloc>().add(AuthClearStatus());
            }

            if (state.status == AuthStatus.failure) {
              final errorMessage = state.errorMessage ?? 'Произошла ошибка';
              showToast(context, errorMessage,
                  focus: WidgetsBinding.instance.window.viewInsets.bottom > 0);
              context.read<AuthBloc>().add(AuthClearStatus());
            }
          },
          builder: (context, state) {
            final bloc = context.read<AuthBloc>();

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: ListView(
                  clipBehavior: Clip.none,
                  children: [
                    const SizedBox(height: 30),
                    TextInputForm(
                      controller: _nameController,
                      prefix: SvgPicture.asset(
                        '$pathForImage${AppImage.profile}',
                        fit: BoxFit.scaleDown,
                      ),
                      keyboardType: TextInputType.text,
                      hintText: 'Имя',
                      errorText: state.errorName,
                    ),
                    const SizedBox(height: 20),
                    TextInputForm(
                      controller: _surnameController,
                      prefix: SvgPicture.asset(
                        '$pathForImage${AppImage.profile}',
                        fit: BoxFit.scaleDown,
                      ),
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
                                    showToast(context, "Правилам сервис",
                                        focus: WidgetsBinding.instance.window
                                                .viewInsets.bottom >
                                            0);
                                  },
                                text: 'правилами сервиса ',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 27, 194, 122))),
                            TextSpan(text: 'и '),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showToast(
                                        context, 'Политикой конфидециальности',
                                        focus: WidgetsBinding.instance.window
                                                .viewInsets.bottom >
                                            0);
                                  },
                                text: 'политикой конфидециальности',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 27, 194, 122))),
                          ],
                        ),
                      ),
                    ),
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
