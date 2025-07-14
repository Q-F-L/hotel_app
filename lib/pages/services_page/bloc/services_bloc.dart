import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<ServicesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
