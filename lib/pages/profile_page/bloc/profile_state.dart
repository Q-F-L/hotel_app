part of 'profile_bloc.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class CheckOutState extends ProfileState {}

class LogoutState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});
}
