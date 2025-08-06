part of 'services_bloc.dart';

enum ServicesStatus { initial, loading, success, failure, send }

class ServicesState {
  final List<Services>? listServices;
  final ServicesStatus? status;
  final String? errorMessage;

  const ServicesState({
    this.listServices,
    this.status,
    this.errorMessage,
  });

  ServicesState copyWith({
    List<Services>? listServices,
    ServicesStatus? status,
    String? errorMessage,
  }) {
    return ServicesState(
      listServices: listServices ?? this.listServices,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ServicesInitial extends ServicesState {}
