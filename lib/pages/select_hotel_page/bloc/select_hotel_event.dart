part of 'select_hotel_bloc.dart';

@immutable
sealed class SelectHotelEvent {}

class RoleChanged extends SelectHotelEvent {
  final String? role;
  RoleChanged(this.role);
}
