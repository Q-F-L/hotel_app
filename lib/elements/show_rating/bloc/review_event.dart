part of 'review_bloc.dart';

abstract class ReviewEvent {}

class ChangeRatingEvent extends ReviewEvent {
  final double rating;

  ChangeRatingEvent(this.rating);
}

class ChangeCommentEvent extends ReviewEvent {
  final String comment;

  ChangeCommentEvent(this.comment);
}

class SendReviewEvent extends ReviewEvent {
  final int orderId;

  SendReviewEvent(this.orderId);
}