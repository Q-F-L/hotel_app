import 'package:flutter/material.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';
import 'package:m_softer_test_project/elements/gradient_floating_action_button.dart';
import 'package:m_softer_test_project/elements/service_ticket.dart';

import '../../elements/custom_bottom_navigation_bar.dart';
import '../../themes/themes.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CustomBottomNabigationBar(nowPage: "/services"),
      appBar: CustomAppbar(
        title: "Сервисы",
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
      ),
      // bottomNavigationBar: CustomBottomNabigationBar(),
      floatingActionButton: GradientFloatingActionButton(
        firstColor: Color.fromARGB(255, 83, 232, 140),
        secondColor: Color.fromARGB(255, 21, 190, 120),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.backgroundWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
            ServiceTicket(),
          ],
        ),
      ),
    );
  }
}
