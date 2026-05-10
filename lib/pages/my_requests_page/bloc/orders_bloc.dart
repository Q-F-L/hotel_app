import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/data/services/models/order.dart';
import 'package:m_softer_test_project/data/services/requests.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<LoadOrdersEvent>((event, emit) async {
      emit(OrdersLoading());

      try {
        final orders = await ServicesRequest.orders();

        if (orders.message != null &&
            orders.message!.contains("Ошибка")) {
          emit(OrdersError(orders.message!));
        } else {
          emit(OrdersLoaded(orders));
        }
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });
  }
}