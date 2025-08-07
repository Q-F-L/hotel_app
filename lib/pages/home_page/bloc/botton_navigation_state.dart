part of 'botton_navigation_bloc.dart';

class BottonNavigationState {
  final int nowPage;
  BottonNavigationState({required this.nowPage});

  BottonNavigationState copyWith({
    required int nowPage,
  }) {
    return BottonNavigationState(nowPage: nowPage);
  }
}

final class BottonNavigationInitial extends BottonNavigationState {
  BottonNavigationInitial({required super.nowPage});
}
