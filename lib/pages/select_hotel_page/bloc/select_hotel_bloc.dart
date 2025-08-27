import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/organizations/model.dart';
import 'package:m_softer_test_project/data/organizations/requests.dart';
import 'package:m_softer_test_project/data/rooms/model.dart';
import 'package:m_softer_test_project/data/rooms/requests.dart';
import 'package:m_softer_test_project/data/user/models/check_model.dart';
import 'package:m_softer_test_project/data/user/models/user.dart';
import 'package:m_softer_test_project/data/user/requests.dart';

part 'select_hotel_event.dart';
part 'select_hotel_state.dart';

class SelectHotelBloc extends Bloc<SelectHotelEvent, SelectHotelState> {
  bool canClick = false;

  SelectHotelBloc() : super(SelectHotelInitial()) {
    on<RequestHotelsEvent>(_requestHotelsEvent);
    on<SelectedHotelEvent>(_selectedHotel);
    on<SelectedRoomEvent>(_selectedRoom);
    on<SelectedDateEvent>(_selectedDate);
    on<SendEvent>(_send);
  }

  _send(SendEvent event, Emitter<SelectHotelState> emit) async {
    final CheckModel jsonModel = await ProfileRequest.checkIn(
        state.rooms?.id ?? 0, state.date ?? 'Нет даты');

    try {
      if (jsonModel.success == true) {
        User.checkedIn = true;
        emit(state.copyWith(status: SelectHotelStatus.send));
      } else {
        emit(state.copyWith(
          status: SelectHotelStatus.failure,
          errorMessage: jsonModel.error ?? jsonModel.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SelectHotelStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  _requestHotelsEvent(
      RequestHotelsEvent event, Emitter<SelectHotelState> emit) async {
    emit(state.copyWith(status: SelectHotelStatus.loading));

    User.id ?? await User.create();

    if (User.checkedIn ?? false) {
      emit(state.copyWith(status: SelectHotelStatus.complited));
      return;
    }

    try {
      final Hotel jsonModel = await OrganizationsRequest.create();

      if (jsonModel.success == true) {
        emit(state.copyWith(
          status: SelectHotelStatus.success,
          listHotel: jsonModel.organizations,
        ));
      } else {
        emit(state.copyWith(
          status: SelectHotelStatus.failure,
          errorMessage: jsonModel.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SelectHotelStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  _selectedHotel(
      SelectedHotelEvent event, Emitter<SelectHotelState> emit) async {
    emit(state.copyWith(hotel: event.hotel));

    final RoomsModel jsonModel =
        await RoomsRequest.create(event.hotel?.id ?? 0);

    try {
      if (jsonModel.success == true) {
        emit(state.copyWith(
          status: SelectHotelStatus.success,
          listRooms: jsonModel.rooms,
        ));
      } else {
        emit(state.copyWith(
          status: SelectHotelStatus.failure,
          errorMessage: jsonModel.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SelectHotelStatus.failure,
        errorMessage: jsonModel.message,
      ));
    }
  }

  _selectedRoom(SelectedRoomEvent event, Emitter<SelectHotelState> emit) {
    emit(state.copyWith(
      rooms: event.rooms,
    ));

    canClick = state.hotel != null && state.rooms != null && state.date != null;
  }

  _selectedDate(SelectedDateEvent event, Emitter<SelectHotelState> emit) {
    emit(state.copyWith(
      date: event.date,
    ));

    canClick = state.hotel != null && state.rooms != null && state.date != null;
  }
}
