import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/pages/bottom_navigation/botton_navigation.dart';
import 'package:m_softer_test_project/pages/my_requests_page/my_requests_page.dart';
import 'package:m_softer_test_project/pages/shower_new_page/showers_page.dart';

import 'data/token.dart';
import 'pages/auth_page/auth_page.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';
import 'pages/auth_page/register_page.dart';
import 'pages/profile_page/profile_page.dart';
import 'pages/qr_code_page/qr_code_page.dart';
import 'pages/select_hotel_page/select_hotel.dart';
import 'pages/services_page/services_page.dart';
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
        color: Colors.transparent,
        title: 'Flutter Demo',
        theme: createLightTheme(),
        routes: {
          '/auth': (context) => AuthPage(),
          '/registration': (context) => RegistrationPage(),
          '/select_home': (context) => SelectHome(),
          '/services': (context) => ServicesPage(),
          '/requsts': (context) => MyRequestsPage(),
          '/profile': (context) => ProfilePage(),
          '/qr_code_page': (context) => QrCodePage(),
          '/shower': (context) => Showers(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStatus.initial ||
                state.status == AuthStatus.loading) {
              return Scaffold(
                body: CircularProgressIndicator(),
              );
            } else if (state.status == AuthStatus.authenticated) {
              return const BottonNavigation();
            } else {
              return const Showers();
            }
          },
        ),
      ),
    );
  }
}
