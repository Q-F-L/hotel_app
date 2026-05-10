part of 'orders_bloc.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final OrderModel orderModel;

  OrdersLoaded(this.orderModel);
}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}