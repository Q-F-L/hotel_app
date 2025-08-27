import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class BottonNavigationBloc extends Bloc<HomeEvent, HomeState> {
  BottonNavigationBloc() : super(HomeInitial(nowPage: 1)) {
    on<BNMoveToEvent>(_bNMoveTo);
  }

  _bNMoveTo(BNMoveToEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(nowPage: event.selectedPage));
  }
}
