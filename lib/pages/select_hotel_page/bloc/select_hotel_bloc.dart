import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/hotels.dart';
import 'package:m_softer_test_project/data/rooms.dart';

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
    final response = await http.post(
      Uri.parse('https://app.successhotel.ru/api/client/check-in'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 96|r2BwEwOzCUsYqSbbNlP3iP74ZT8oaigvc65cE6yk'
      },
      body: jsonEncode({
        'room_id': state.rooms!.id,
        'chek_in_date': state.date,
      }),
    );

    final json = jsonDecode(response.body);

    try {
      if (response.statusCode == 200 && json['success'] == true) {
        emit(state.copyWith(status: SelectHotelStatus.send));
      } else {
        emit(state.copyWith(status: SelectHotelStatus.loading));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SelectHotelStatus.failure,
        errorMessage: json['message'],
      ));
      print("Error ${e}");
    }
  }

  _requestHotelsEvent(
      RequestHotelsEvent event, Emitter<SelectHotelState> emit) async {
    try {
      final response = await http.get(
        Uri.parse('https://app.successhotel.ru/api/client/organizations'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 96|r2BwEwOzCUsYqSbbNlP3iP74ZT8oaigvc65cE6yk'
        },
      );

      final json = jsonDecode(response.body);
      Hotel hotel = Hotel.fromJson(json);

      if (response.statusCode == 200 && json['success'] == true) {
        emit(state.copyWith(
          status: SelectHotelStatus.success,
          listHotel: hotel.organizations,
        ));
      } else {
        emit(state.copyWith(
          status: SelectHotelStatus.failure,
          errorMessage: json['message'],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: SelectHotelStatus.failure,
        errorMessage: 'Ошибка соединения',
      ));
    }
  }

  _selectedHotel(
      SelectedHotelEvent event, Emitter<SelectHotelState> emit) async {
    emit(state.copyWith(hotel: event.hotel));

    try {
      final response = await http.get(
        Uri.parse(
            'https://app.successhotel.ru/api/client/organizations/${event.hotel!.id}/rooms'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 96|r2BwEwOzCUsYqSbbNlP3iP74ZT8oaigvc65cE6yk'
        },
      );

      final json = jsonDecode(response.body);
      RoomsRequest roomsRequest = RoomsRequest.fromJson(json);
      if (response.statusCode == 200 && json['success'] == true) {
        emit(state.copyWith(
          status: SelectHotelStatus.success,
          listRooms: roomsRequest.rooms,
        ));
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print(e);

      // errorMessage: 'Ошибка соединения',
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
