part of 'shower_new_page_bloc.dart';

class ShowerNewPageState {}

class ShowerNewPageInitial extends ShowerNewPageState {}

class NextPage extends ShowerNewPageState {
  final int currentPage;

  NextPage(this.currentPage);
}
