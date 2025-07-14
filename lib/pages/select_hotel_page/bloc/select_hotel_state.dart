part of 'select_hotel_bloc.dart';

@immutable
sealed class SelectHotelState {}

class SelectHotelInitial extends SelectHotelState {
  final String? selectedRole;

  SelectHotelInitial({this.selectedRole});

  SelectHotelInitial copyWith({
    String? selectedRole,
  }) {
    return SelectHotelInitial(
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
}
