part of 'qr_code_page_bloc.dart';

sealed class QrCodeEvent {}

class ScanQrCodeEvent extends QrCodeEvent {
  final String? response;

  ScanQrCodeEvent({this.response});
}
