part of 'cancel_bloc.dart';

abstract class CancelOrderState {}

class CancelOrderInitial extends CancelOrderState {
  final String comment;

  CancelOrderInitial({
    this.comment = '',
  });
}

class CancelOrderLoading extends CancelOrderState {}

class CancelOrderSuccess extends CancelOrderState {
  final String message;

  CancelOrderSuccess(this.message);
}

class CancelOrderError extends CancelOrderState {
  final String error;

  CancelOrderError(this.error);
}