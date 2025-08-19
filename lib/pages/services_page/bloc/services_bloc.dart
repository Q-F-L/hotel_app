import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/services/model.dart';
import 'package:m_softer_test_project/data/services/requests.dart';
part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<ServicesInitialEvent>(_requestAllServices);
  }

  _requestAllServices(
      ServicesInitialEvent event, Emitter<ServicesState> emit) async {
    emit(state.copyWith(
      status: ServicesStatus.loading,
    ));

    final ServicesModel jsonModel = await ServicesRequest.create();

    try {
      if (jsonModel.success == true) {
        emit(state.copyWith(
          listServices: jsonModel.services,
          status: ServicesStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: ServicesStatus.failure,
          errorMessage: jsonModel.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ServicesStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
