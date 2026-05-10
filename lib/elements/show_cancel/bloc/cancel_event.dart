part of 'cancel_bloc.dart';

abstract class CancelOrderEvent {}

class ChangeCancelCommentEvent extends CancelOrderEvent {
  final String comment;

  ChangeCancelCommentEvent(this.comment);
}

class SendCancelOrderEvent extends CancelOrderEvent {
  final int orderId;

  SendCancelOrderEvent(this.orderId);
}