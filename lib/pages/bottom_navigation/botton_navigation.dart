import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';
import 'package:m_softer_test_project/elements/custom_bottom_navigation_bar.dart';
import 'package:m_softer_test_project/elements/gradient_floating_action_button.dart';
import 'package:m_softer_test_project/pages/bottom_navigation/bloc/botton_navigation_bloc.dart';
import 'package:m_softer_test_project/pages/my_requests_page/my_requests_page.dart';
import 'package:m_softer_test_project/pages/profile_page/profile_page.dart';
import 'package:m_softer_test_project/pages/services_page/services_page.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class BottonNavigation extends StatefulWidget {
  const BottonNavigation({super.key});

  @override
  State<BottonNavigation> createState() => _BottonNavigationState();
}

class _BottonNavigationState extends State<BottonNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottonNavigationBloc(),
      child: BlocConsumer<BottonNavigationBloc, BottonNavigationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            bottomSheet: CustomBottomNavigationBar(),
            appBar: CustomAppbar(
              title: ["Мои запросы", "Сервисы", "Мой профиль"][state.nowPage],
              preferredSize: Size(MediaQuery.of(context).size.width, 100),
            ),
            floatingActionButton: GradientFloatingActionButton(
              onPressed: () => context
                  .read<BottonNavigationBloc>()
                  .add(BNMoveToEvent(selectedPage: 1)),
              firstColor: Color.fromARGB(255, 83, 232, 140),
              secondColor: Color.fromARGB(255, 21, 190, 120),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            backgroundColor: AppColors.backgroundWhite,
            body: [
              MyRequestsPage(),
              ServicesPage(),
              ProfilePage()
            ][state.nowPage],
          );
        },
      ),
    );
  }
}
