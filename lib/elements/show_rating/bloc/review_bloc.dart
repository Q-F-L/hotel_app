import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/data/services/requests.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  double rating = 3;
  String comment = '';

  ReviewBloc() : super(ReviewInitial()) {
    on<ChangeRatingEvent>((event, emit) {
      rating = event.rating;

      emit(
        ReviewInitial(
          rating: rating,
          comment: comment,
        ),
      );
    });

    on<ChangeCommentEvent>((event, emit) {
      comment = event.comment;

      emit(
        ReviewInitial(
          rating: rating,
          comment: comment,
        ),
      );
    });

    on<SendReviewEvent>((event, emit) async {
      try {
        emit(ReviewLoading());

        final response = await ServicesRequest.sendReview(
          orderId: event.orderId,
          comment: comment,
          rating: rating.toInt(),
        );

        if(response.error != '') {
          throw Exception(response.error);
        }

        emit(
          ReviewSuccess(response.message),
        );
      } catch (e) {
        emit(
          ReviewError(e.toString()),
        );
      }
    });
  }
}