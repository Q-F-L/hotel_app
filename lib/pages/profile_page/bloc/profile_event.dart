part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class CreateProfileEvent extends ProfileEvent {}

class CheckOutEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

class DeleteUser extends ProfileEvent {}
