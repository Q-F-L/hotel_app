import 'package:bloc/bloc.dart';

part 'qr_code_page_event.dart';
part 'qr_code_page_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeBloc() : super(QrCodePageInitial()) {
    on<QrCodeEvent>((ev, et) {});
    on<ScanQrCodeEvent>(_scanQrCodeEvent);
  }

  _scanQrCodeEvent(ScanQrCodeEvent event, Emitter<QrCodeState> emit) {
    emit(state.copyWith(response: event.response));
  }
}
