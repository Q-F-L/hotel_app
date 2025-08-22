import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/services/models/order.dart';
import 'package:m_softer_test_project/data/services/models/services.dart';
import 'package:m_softer_test_project/data/services/requests.dart';
import 'package:url_launcher/url_launcher.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<ServicesInitialEvent>(_requestAllServices);
    on<CreateOrder>(_createOrder);
  }

  _createOrder(CreateOrder event, Emitter<ServicesState> emit) async {
    final OrderModel jsonModel = await ServicesRequest.createOreder(
        event.servicesId ?? 0, event.options ?? []);

    try {
      if (jsonModel.success == true) {
        emit(state.copyWith(
          status: ServicesStatus.order,
          url: jsonModel.confirmationUrl,
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
