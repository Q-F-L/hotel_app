import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/data/services/requests.dart';

part 'cancel_event.dart';
part 'cancel_state.dart';

class CancelOrderBloc
    extends Bloc<CancelOrderEvent, CancelOrderState> {
  String comment = '';

  CancelOrderBloc() : super(CancelOrderInitial()) {
    on<ChangeCancelCommentEvent>((event, emit) {
      comment = event.comment;

      emit(
        CancelOrderInitial(
          comment: comment,
        ),
      );
    });

    on<SendCancelOrderEvent>((event, emit) async {
      try {
        emit(CancelOrderLoading());

        final response =
        await ServicesRequest.cancelOrder(
          orderId: event.orderId,
          comment: comment,
        );
        if(response.error != '') {
          throw Exception(response.error);
        }
        emit(
          CancelOrderSuccess(response.message),
        );
      } catch (e) {
        emit(
          CancelOrderError(e.toString()),
        );
      }
    });
  }
}