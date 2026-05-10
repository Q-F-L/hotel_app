import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/card_request.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';

import 'bloc/orders_bloc.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersBloc()..add(LoadOrdersEvent()),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: CustomAppbar(
              title: "Мои запросы",
            ),
          ),

          Expanded(
            flex: 13,
            child: BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {

                /// Loading
                if (state is OrdersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                /// ERROR
                if (state is OrdersError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                /// Loaded
                if (state is OrdersLoaded) {

                  final orders = state.orderModel.orders ?? [];

                  if (orders.isEmpty) {
                    return const Center(
                      child: Text("Нет запросов"),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {

                      final order = orders[index];

                      return CardRequest(
                        order: order,
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}