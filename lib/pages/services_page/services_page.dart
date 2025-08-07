import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/service_ticket.dart';
import 'package:m_softer_test_project/pages/services_page/bloc/services_bloc.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicesBloc()..add(ServicesInitialEvent()),
      child: BlocConsumer<ServicesBloc, ServicesState>(
        listener: (context, state) {
          if (state.status == ServicesStatus.failure) {
            showCustomSnackBar(context, "Error message: ${state.errorMessage}");
          }
        },
        builder: (context, state) {
          if (state.status == ServicesStatus.loading ||
              (state.listServices == null || state.listServices!.isEmpty)) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == ServicesStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? "Произошла ошибка",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ListView.builder(
              itemCount: state.listServices?.length ?? 1,
              itemBuilder: (context, index) => ServiceTicket(
                service: state.listServices![index],
              ),
            ),
          );
        },
      ),
    );
  }
}
