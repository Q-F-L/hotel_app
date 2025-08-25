import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';
import 'package:m_softer_test_project/elements/custom_bottom_navigation_bar.dart';
import 'package:m_softer_test_project/elements/gradient_floating_action_button.dart';
import 'package:m_softer_test_project/pages/home_page/bloc/home_bloc.dart';
import 'package:m_softer_test_project/pages/my_requests_page/my_requests_page.dart';
import 'package:m_softer_test_project/pages/profile_page/profile_page.dart';
import 'package:m_softer_test_project/pages/services_page/services_page.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottonNavigationBloc(),
      child: BlocConsumer<BottonNavigationBloc, HomeState>(
        listener: (context, state) {
          _pageController.animateToPage(
            state.nowPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomSheet: CustomBottomNavigationBar(),
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
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const [MyRequestsPage(), ServicesPage(), ProfilePage()],
            ),
          );
        },
      ),
    );
  }
}
