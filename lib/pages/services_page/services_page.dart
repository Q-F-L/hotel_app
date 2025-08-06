import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/service_ticket.dart';
import 'package:m_softer_test_project/pages/services_page/bloc/services_bloc.dart';

import '../../data/services.dart';

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
    return BlocProvider(
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
    );
  }
}
