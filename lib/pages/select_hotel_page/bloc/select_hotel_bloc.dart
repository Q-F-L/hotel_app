import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_hotel_event.dart';
part 'select_hotel_state.dart';

class SelectHotelBloc extends Bloc<SelectHotelEvent, SelectHotelState> {
  bool canClick = false;

  SelectHotelBloc() : super(SelectHotelInitial()) {
    on<SelectHotelEvent>((event, emit) {});

    on<SelectedHomelEvent>(selectedHome);

    on<SelectedNumberEvent>(selectedNumber);

    on<SelectedDateEvent>(selectedDate);
  }

  selectedHome(SelectedHomelEvent event, Emitter<SelectHotelState> emit) {
    emit(state.copyWith(nameHotel: event.name));
  }

  selectedNumber(SelectedNumberEvent event, Emitter<SelectHotelState> emit) {
    emit(state.copyWith(
      number: event.name,
    ));

    canClick =
        state.nameHotel != null && state.number != null && state.date != null;
  }

  selectedDate(SelectedDateEvent event, Emitter<SelectHotelState> emit) {
    emit(state.copyWith(
      date: event.date,
    ));

    canClick =
        state.nameHotel != null && state.number != null && state.date != null;
  }
}
