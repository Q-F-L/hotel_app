part of 'launch_bloc.dart';

abstract class LaunchEvent {}

class CheckFirstLaunchEvent extends LaunchEvent {}

class CompleteShowersEvent extends LaunchEvent {}
