import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/pages/home_page/home.dart';
import 'package:m_softer_test_project/pages/launch_bloc/launch_bloc.dart';
import 'package:m_softer_test_project/pages/loading_page/loading_page.dart';
import 'package:m_softer_test_project/pages/shower_new_page/showers_page.dart';

import 'data/token.dart';
import 'pages/auth_page/auth_page.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';
import 'pages/auth_page/register_page.dart';
import 'pages/qr_code_page/qr_code_page.dart';
import 'pages/select_hotel_page/select_hotel.dart';
import 'themes/themes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authBloc = AuthBloc(tokenRepository: TokenRepository());

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => authBloc..add(AuthCheckToken()),
        ),
        BlocProvider<LaunchBloc>(
          create: (BuildContext context) =>
              LaunchBloc()..add(CheckFirstLaunchEvent()),
        ),
      ],
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
        home: LoadingPage(),
      ),
    );
  }
}
