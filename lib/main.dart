import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/pages/home_page/home.dart';
import 'package:m_softer_test_project/pages/shower_new_page/showers_page.dart';

import 'data/token.dart';
import 'pages/auth_page/auth_page.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';
import 'pages/auth_page/register_page.dart';
import 'pages/qr_code_page/qr_code_page.dart';
import 'pages/select_hotel_page/select_hotel.dart';
import 'themes/themes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenRepository = TokenRepository();
  final authBloc = AuthBloc(tokenRepository: tokenRepository);

  authBloc.add(AuthCheckToken());

  initializeDateFormatting('ru_RU', null).then((_) => runApp(MyApp(
        authBloc: authBloc,
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authBloc});
  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.transparent,
        title: 'Flutter Demo',
        theme: createLightTheme(),
        routes: {
          '/auth': (context) => AuthPage(),
          '/registration': (context) => RegistrationPage(),
          '/select_home': (context) => SelectHomePage(),
          '/qr_code_page': (context) => QrCodePage(),
          '/shower': (context) => Showers(),
          '/home': (context) => HomePage(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            switch (state.status) {
              case AuthStatus.initial || AuthStatus.loading:
                return Scaffold(
                  body: CircularProgressIndicator(),
                );
              case AuthStatus.authenticated:
                return HomePage();
              case AuthStatus.unauthenticated:
                return SelectHomePage();
              default:
                return const AuthPage();
            }

            // if (state.status == AuthStatus.initial ||
            //     state.status == AuthStatus.loading) {
            //   return Scaffold(
            //     body: CircularProgressIndicator(),
            //   );
            // } else if (state.status == AuthStatus.authenticated) {
            //   return const SelectHome();
            // } else if () else {
            //   return const Showers();
            // }
          },
        ),
      ),
    );
  }
}
