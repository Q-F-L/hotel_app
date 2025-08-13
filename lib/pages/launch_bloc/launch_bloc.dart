import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(LaunchInitial()) {
    on<CheckFirstLaunchEvent>(_onCheckFirstLaunch);
    on<CompleteShowersEvent>(_onCompleteShowers);
  }

  Future<void> _onCheckFirstLaunch(
      CheckFirstLaunchEvent event, Emitter<LaunchState> emit) async {
    emit(LaunchLoading());

    final prefs = await SharedPreferences.getInstance();
    final hasSeenShowers = prefs.getBool('hasSeenShowers') ?? false;

    if (hasSeenShowers) {
      emit(LaunchNotFirstTime());
    } else {
      emit(LaunchFirstTime());
    }
  }

  Future<void> _onCompleteShowers(
      CompleteShowersEvent event, Emitter<LaunchState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenShowers', true);
    emit(LaunchNotFirstTime());
  }
}
