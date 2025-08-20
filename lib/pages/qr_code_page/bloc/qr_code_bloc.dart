import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/room_by_code/model.dart';
import 'package:m_softer_test_project/data/room_by_code/requests.dart';
import 'package:m_softer_test_project/data/user/requests.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeBloc() : super(QrCodePageInitial()) {
    on<QrCodeEvent>((ev, et) {});
    on<ScanQrCodeEvent>(_scanQrCodeEvent);
    on<CheckIn>(_checkIn);
  }

  _checkIn(CheckIn event, Emitter<QrCodeState> emit) async {
    await ProfileRequest.checkIn(event.roomId, event.date);

    emit(CheckInSuccess());
  }

  _scanQrCodeEvent(ScanQrCodeEvent event, Emitter<QrCodeState> emit) async {
    print("event.response ${event.response}");
    emit(state.copyWith(status: QrCodeStatus.loading));
    try {
      String qrCode = event.response!.split('/').last;

      final RoomByCodeModel jsonModel = await RoomByCodeRequest.send(qrCode);

      if (jsonModel.success == true) {
        emit(state.copyWith(
          status: QrCodeStatus.success,
          oraganizationIfno: jsonModel,
        ));
      } else {
        emit(state.copyWith(
          status: QrCodeStatus.failure,
          errorMessage:
              jsonModel.error ?? jsonModel.message ?? "Неизвестная ошибка",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          status: QrCodeStatus.success, errorMessage: e.toString()));
    }
  }
}
