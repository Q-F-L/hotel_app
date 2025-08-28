import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool _isFromNavBar = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 1,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottonNavigationBloc(),
      child: BlocConsumer<BottonNavigationBloc, HomeState>(
        listener: (context, state) {
          _isFromNavBar = true;

          _pageController
              .animateToPage(
            state.nowPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )
              .then((_) {
            _isFromNavBar = false;
          });
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomSheet: CustomBottomNavigationBar(),
            floatingActionButton: TweenAnimationBuilder<Color?>(
              tween: ColorTween(
                begin: AppColors.white,
                end: state.nowPage == 1
                    ? const Color.fromARGB(255, 83, 232, 140)
                    : AppColors.white,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, firstColor, child) {
                return TweenAnimationBuilder<Color?>(
                  tween: ColorTween(
                    begin: AppColors.white,
                    end: state.nowPage == 1
                        ? const Color.fromARGB(255, 21, 190, 120)
                        : AppColors.white,
                  ),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, secondColor, child) {
                    return TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: AppColors.realBlack,
                        end: state.nowPage == 1
                            ? AppColors.white
                            : AppColors.realBlack,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, iconColor, child) {
                        return GradientFloatingActionButton(
                          onPressed: () => context
                              .read<BottonNavigationBloc>()
                              .add(BNMoveToEvent(selectedPage: 1)),
                          firstColor: firstColor!,
                          secondColor: secondColor!,
                          iconColor: iconColor!,
                        );
                      },
                    );
                  },
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            backgroundColor: AppColors.backgroundWhite,
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                if (!_isFromNavBar) {
                  context
                      .read<BottonNavigationBloc>()
                      .add(BNMoveToEvent(selectedPage: index));
                }
              },
              children: const [MyRequestsPage(), ServicesPage(), ProfilePage()],
            ),
          );
        },
      ),
    );
  }
}
