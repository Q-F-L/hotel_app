import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_requests_event.dart';
part 'my_requests_state.dart';

class MyRequestsBloc extends Bloc<MyRequestsEvent, MyRequestsState> {
  MyRequestsBloc() : super(MyRequestsInitial()) {
    on<MyRequestsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
