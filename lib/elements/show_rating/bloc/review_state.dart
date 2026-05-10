part of 'review_bloc.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {
  final double rating;
  final String comment;

  ReviewInitial({
    this.rating = 3,
    this.comment = '',
  });
}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final String message;

  ReviewSuccess(this.message);
}

class ReviewError extends ReviewState {
  final String error;

  ReviewError(this.error);
}