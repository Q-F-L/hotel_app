part of 'select_hotel_bloc.dart';

@immutable
sealed class SelectHotelEvent {}

class SelectedHomelEvent extends SelectHotelEvent {
  final String? name;
  SelectedHomelEvent(this.name);
}

class SelectedNumberEvent extends SelectHotelEvent {
  final String? name;
  SelectedNumberEvent(this.name);
}

class SelectedDateEvent extends SelectHotelEvent {
  final String? date;
  SelectedDateEvent(this.date);
}
