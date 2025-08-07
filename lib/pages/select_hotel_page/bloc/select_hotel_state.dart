part of 'select_hotel_bloc.dart';

enum SelectHotelStatus { initial, loading, success, failure, send, complited }

class SelectHotelState {
  final Organizations? hotel;
  final Rooms? rooms;
  final String? date;
  final SelectHotelStatus? status;
  final String? errorMessage;
  final List<Rooms?>? listRooms;
  final List<Organizations?>? listHotel;

  const SelectHotelState({
    this.status = SelectHotelStatus.initial,
    this.rooms,
    this.date,
    this.hotel,
    this.errorMessage,
    this.listHotel,
    this.listRooms,
  });

  SelectHotelState copyWith({
    Organizations? hotel,
    List<Organizations?>? listHotel,
    Rooms? rooms,
    List<Rooms?>? listRooms,
    String? date,
    SelectHotelStatus? status,
    String? errorMessage,
  }) {
    return SelectHotelState(
      hotel: hotel ?? this.hotel,
      listHotel: listHotel ?? this.listHotel,
      rooms: rooms ?? this.rooms,
      listRooms: listRooms ?? this.listRooms,
      date: date ?? this.date,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SelectHotelInitial extends SelectHotelState {}
