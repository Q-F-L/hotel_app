import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shower_new_page_event.dart';
part 'shower_new_page_state.dart';

class ShowerNewPageBloc extends Bloc<ShowerNewPageEvent, ShowerNewPageState> {
  PageController pageController;

  ShowerNewPageBloc(this.pageController) : super(ShowerNewPageInitial()) {
    on<NewPage>(_newPage);
  }

  _newPage(NewPage event, Emitter<ShowerNewPageState> emit) async {
    int nextPage = pageController.page!.toInt() + 1;
    if (nextPage < 3) {
      await pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(NextPage(nextPage));
    }
  }
}
