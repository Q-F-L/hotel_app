import 'package:flutter/material.dart';
import 'package:m_softer_test_project/pages/my_requests_page/my_requests_page.dart';
import 'package:m_softer_test_project/pages/shower_new_page/showers_page.dart';

import 'pages/auth_page/auth_page.dart';
import 'pages/auth_page/register_page.dart';
import 'pages/profile_page/profile_page.dart';
import 'pages/qr_code_page/qr_code_page.dart';
import 'pages/select_hotel_page/select_hotel.dart';
import 'pages/services_page/services_page.dart';
import 'themes/themes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ru_RU', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: AuthPage(),
    );
  }
}
