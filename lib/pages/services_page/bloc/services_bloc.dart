import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/services.dart';
import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/token.dart';
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

    final tokenRepository = TokenRepository();
    final token = await tokenRepository.getToken();
    final response = await http.get(
      Uri.parse('https://app.successhotel.ru/api/client/services'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    final json = jsonDecode(response.body);
    ServicesRequest servicesRequest = ServicesRequest.fromJson(json);

    try {
      if (response.statusCode == 200) {
        emit(state.copyWith(
          listServices: servicesRequest.services,
          status: ServicesStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: ServicesStatus.failure,
          errorMessage: json['message'],
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
