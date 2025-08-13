part of 'launch_bloc.dart';

abstract class LaunchState {}

class LaunchInitial extends LaunchState {}

class LaunchLoading extends LaunchState {}

class LaunchFirstTime extends LaunchState {}

class LaunchNotFirstTime extends LaunchState {}
