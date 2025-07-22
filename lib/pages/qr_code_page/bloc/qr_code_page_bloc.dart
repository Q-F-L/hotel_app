import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qr_code_page_event.dart';
part 'qr_code_page_state.dart';

class QrCodePageBloc extends Bloc<QrCodePageEvent, QrCodePageState> {
  QrCodePageBloc() : super(QrCodePageInitial()) {
    on<QrCodePageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
