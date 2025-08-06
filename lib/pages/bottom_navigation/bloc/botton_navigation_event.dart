part of 'botton_navigation_bloc.dart';

sealed class BottonNavigationEvent {}

class BNMoveToEvent extends BottonNavigationEvent {
  final int selectedPage;

  BNMoveToEvent({required this.selectedPage});
}
