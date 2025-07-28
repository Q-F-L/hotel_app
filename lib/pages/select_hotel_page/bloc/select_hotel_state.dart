part of 'select_hotel_bloc.dart';

enum SelectHotelStatus { initial, loading, success, failure }

@immutable
class SelectHotelState {
  final String? nameHotel;
  final String? number;
  final String? date;
  final SelectHotelStatus? status;

  const SelectHotelState(
      {this.status = SelectHotelStatus.initial,
      this.number,
      this.date,
      this.nameHotel});

  SelectHotelState copyWith({
    String? nameHotel,
    String? number,
    String? date,
    SelectHotelStatus? status,
  }) {
    return SelectHotelState(
      nameHotel: nameHotel ?? this.nameHotel,
      number: number ?? this.number,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}

class SelectHotelInitial extends SelectHotelState {}
