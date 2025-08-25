import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';
import 'package:m_softer_test_project/elements/service_ticket.dart';
import 'package:m_softer_test_project/pages/services_page/bloc/services_bloc.dart';
import 'package:m_softer_test_project/pages/web_pay_page/web_pay_page.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late ServicesBloc bloc;

  @override
  void initState() {
    bloc = ServicesBloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(ServicesInitialEvent()),
      child: BlocConsumer<ServicesBloc, ServicesState>(
        listener: (context, state) {
          if (state.status == ServicesStatus.failure) {
            showToast(context, "Error message: ${state.errorMessage}");
          }

          if (state.status == ServicesStatus.order) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PaymentWebViewScreen(
                  url: state.url ?? "",
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == ServicesStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if ((state.listServices == null || state.listServices!.isEmpty)) {
            return Center(
              child: Text(
                "Тут пусто!",
                style: Theme.of(context).textTheme.labelLarge,
              ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppbar(
                  title: "Сервисы",
                  preferredSize: Size(MediaQuery.of(context).size.width, 124),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 132,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    itemCount: state.listServices?.length ?? 1,
                    itemBuilder: (context, index) => ServiceTicket(
                      service: state.listServices![index],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
