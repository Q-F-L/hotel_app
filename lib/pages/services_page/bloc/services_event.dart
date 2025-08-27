part of 'services_bloc.dart';

abstract class ServicesEvent {}

class ServicesInitialEvent extends ServicesEvent {}

class CreateOrder extends ServicesEvent {
  final int? servicesId;
  final List<Options>? options;

  CreateOrder({this.servicesId, this.options});
}
