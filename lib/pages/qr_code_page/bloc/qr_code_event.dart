part of 'qr_code_bloc.dart';

sealed class QrCodeEvent {}

class ScanQrCodeEvent extends QrCodeEvent {
  final String? response;

  ScanQrCodeEvent({this.response});
}

class CheckIn extends QrCodeEvent {
  final int roomId;
  final String date;

  CheckIn({required this.roomId, required this.date});
}
