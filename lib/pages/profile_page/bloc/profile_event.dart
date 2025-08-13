part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class CreateProfileEvent extends ProfileEvent {}

class MoveOutEvent extends ProfileEvent {}
