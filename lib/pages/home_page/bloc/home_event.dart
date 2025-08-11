part of 'home_bloc.dart';

sealed class HomeEvent {}

class BNMoveToEvent extends HomeEvent {
  final int selectedPage;

  BNMoveToEvent({required this.selectedPage});
}
