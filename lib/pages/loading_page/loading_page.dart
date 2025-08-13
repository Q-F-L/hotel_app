import 'package:flutter/material.dart';
import 'package:m_softer_test_project/pages/auth_page/auth_page.dart';
import 'package:m_softer_test_project/pages/auth_page/bloc/auth_bloc.dart';
import 'package:m_softer_test_project/pages/error_page/error_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/data/user/user.dart';
import 'package:m_softer_test_project/pages/home_page/home.dart';
import 'package:m_softer_test_project/pages/launch_bloc/launch_bloc.dart';
import 'package:m_softer_test_project/pages/select_hotel_page/select_hotel.dart';
import 'package:m_softer_test_project/pages/shower_new_page/showers_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      builder: (context, launchState) {
        if (launchState is LaunchLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (launchState is LaunchFirstTime) {
          return Showers();
        } else if (launchState is LaunchNotFirstTime) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState.status == AuthStatus.initial ||
                  authState.status == AuthStatus.loading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (authState.status == AuthStatus.authenticated) {
                if (User.checkedIn ?? false) {
                  return HomePage();
                } else {
                  return SelectHomePage();
                }
              } else if (authState.status == AuthStatus.unauthenticated) {
                return AuthPage();
              } else {
                return ErrorPage(
                  errorMessage: authState.errorMessage,
                );
              }
            },
          );
        } else {
          return ErrorPage(
              errorMessage: "Ошибка при определении первого запуска");
        }
      },
    );
  }
}
