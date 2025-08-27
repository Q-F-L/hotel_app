part of 'qr_code_bloc.dart';

enum QrCodeStatus { initial, loading, success, failure }

class QrCodeState {
  final String? response;
  final String? errorMessage;
  final QrCodeStatus? status;
  final RoomByCodeModel? oraganizationIfno;

  QrCodeState(
      {this.response, this.status, this.errorMessage, this.oraganizationIfno});

  QrCodeState copyWith({
    String? response,
    QrCodeStatus? status,
    String? errorMessage,
    RoomByCodeModel? oraganizationIfno,
  }) {
    return QrCodeState(
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      oraganizationIfno: oraganizationIfno ?? this.oraganizationIfno,
    );
  }
}

class CheckInSuccess extends QrCodeState {}

// class QrCodeResponse extends QrCodeState {
//   final RoomByCodeModel oraganizationIfno;

//   QrCodeResponse(this.oraganizationIfno);
// }

class QrCodePageInitial extends QrCodeState {}
