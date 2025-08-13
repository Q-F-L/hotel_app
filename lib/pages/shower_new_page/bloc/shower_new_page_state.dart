part of 'shower_new_page_bloc.dart';

class ShowerNewPageState {
  final bool? seen;

  ShowerNewPageState({this.seen});

  ShowerNewPageState copyWith({bool? seen}) {
    return ShowerNewPageState(seen: seen ?? this.seen);
  }
}

class ShowerNewPageInitial extends ShowerNewPageState {}

class NextPage extends ShowerNewPageState {
  final int currentPage;

  NextPage(this.currentPage);
}
