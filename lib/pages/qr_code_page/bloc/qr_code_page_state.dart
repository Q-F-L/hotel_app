part of 'qr_code_page_bloc.dart';

class QrCodeState {
  final String? response;

  QrCodeState({this.response});

  QrCodeState copyWith({String? response}) {
    return QrCodeState(response: response ?? this.response);
  }
}

class QrCodePageInitial extends QrCodeState {}
