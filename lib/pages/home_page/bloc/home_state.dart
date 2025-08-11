part of 'home_bloc.dart';

class HomeState {
  final int nowPage;
  HomeState({required this.nowPage});

  HomeState copyWith({
    required int nowPage,
  }) {
    return HomeState(nowPage: nowPage);
  }
}

final class HomeInitial extends HomeState {
  HomeInitial({required super.nowPage});
}
