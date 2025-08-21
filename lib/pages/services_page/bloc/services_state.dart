part of 'services_bloc.dart';

enum ServicesStatus { initial, loading, success, failure, send, order }

class ServicesState {
  final List<Services>? listServices;
  final ServicesStatus? status;
  final String? url;
  final String? errorMessage;

  const ServicesState(
      {this.listServices, this.status, this.errorMessage, this.url});

  ServicesState copyWith({
    List<Services>? listServices,
    ServicesStatus? status,
    String? errorMessage,
    String? url,
  }) {
    return ServicesState(
      listServices: listServices ?? this.listServices,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      url: url ?? this.url,
    );
  }
}

class ServicesInitial extends ServicesState {}
