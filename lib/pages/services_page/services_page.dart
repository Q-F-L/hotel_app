import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';
import 'package:m_softer_test_project/elements/gradient_floating_action_button.dart';
import 'package:m_softer_test_project/elements/service_ticket.dart';
import 'package:m_softer_test_project/pages/services_page/bloc/services_bloc.dart';

import '../../data/services.dart';
import '../../elements/custom_bottom_navigation_bar.dart';
import '../../themes/themes.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late ServicesBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = ServicesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: CustomBottomNabigationBar(nowPage: "/services"),
      appBar: CustomAppbar(
        title: "Сервисы",
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
      ),
      floatingActionButton: GradientFloatingActionButton(
        firstColor: Color.fromARGB(255, 83, 232, 140),
        secondColor: Color.fromARGB(255, 21, 190, 120),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.backgroundWhite,
      body: BlocProvider(
        create: (context) => bloc..add(ServicesInitialEvent()),
        child: BlocConsumer<ServicesBloc, ServicesState>(
          listener: (context, state) {
            if (state.status == ServicesStatus.failure) {
              print("Error message: ${state.errorMessage}");
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ListView.builder(
                itemCount: state.listServices?.length ?? 1,
                itemBuilder: (context, index) => ServiceTicket(
                    service: state.listServices?[index] ??
                        Services(name: "Error: нет услуг")),
              ),
            );
          },
        ),
      ),
    );
  }
}
