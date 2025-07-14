import 'package:flutter/material.dart';

import '../../elements/card_request.dart';
import '../../elements/custom_appbar.dart';
import '../../elements/custom_bottom_navigation_bar.dart';
import '../../elements/gradient_floating_action_button.dart';
import '../../themes/themes.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Мои запросы",
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
      ),
      bottomNavigationBar: CustomBottomNabigationBar(),
      floatingActionButton: GradientFloatingActionButton(
        firstColor: Color.fromARGB(255, 83, 232, 140),
        secondColor: Color.fromARGB(255, 21, 190, 120),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.backgroundWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CardRequest(),
            CardRequest(),
            CardRequest(),
            CardRequest(),
          ],
        ),
      ),
    );
  }
}
