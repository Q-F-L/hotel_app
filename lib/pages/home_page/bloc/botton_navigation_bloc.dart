import 'package:bloc/bloc.dart';

part 'botton_navigation_event.dart';
part 'botton_navigation_state.dart';

class BottonNavigationBloc
    extends Bloc<BottonNavigationEvent, BottonNavigationState> {
  BottonNavigationBloc() : super(BottonNavigationInitial(nowPage: 1)) {
    on<BNMoveToEvent>(_bNMoveTo);
  }

  _bNMoveTo(BNMoveToEvent event, Emitter<BottonNavigationState> emit) {
    emit(state.copyWith(nowPage: event.selectedPage));
  }
}
