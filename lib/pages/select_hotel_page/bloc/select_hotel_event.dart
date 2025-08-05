part of 'select_hotel_bloc.dart';

sealed class SelectHotelEvent {}

class SelectedHotelEvent extends SelectHotelEvent {
  final Organizations? hotel;
  SelectedHotelEvent(this.hotel);
}

class SelectedRoomEvent extends SelectHotelEvent {
  final Rooms? rooms;
  SelectedRoomEvent(this.rooms);
}

class SelectedDateEvent extends SelectHotelEvent {
  final String? date;
  SelectedDateEvent(this.date);
}

class RequestHotelsEvent extends SelectHotelEvent {}

class SendEvent extends SelectHotelEvent {}
