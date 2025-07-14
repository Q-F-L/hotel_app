import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_hotel_event.dart';
part 'select_hotel_state.dart';

class SelectHotelBloc extends Bloc<SelectHotelEvent, SelectHotelState> {
  SelectHotelBloc() : super(SelectHotelInitial()) {
    on<SelectHotelEvent>((event, emit) {});
  }
}
