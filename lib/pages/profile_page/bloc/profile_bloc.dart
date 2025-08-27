import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/data/user/models/check_model.dart';
import 'package:m_softer_test_project/data/user/requests.dart';
import 'package:m_softer_test_project/data/user/models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<CreateProfileEvent>(_createProfile);

    on<CheckOutEvent>(_checkOut);
    on<LogoutEvent>(_onLogout);
    on<DeleteUser>(_deleteUser);
  }

  _createProfile(ProfileEvent event, Emitter emit) async {
    User.id ?? await User.create();
  }

  Future<void> _checkOut(
      CheckOutEvent event, Emitter<ProfileState> emit) async {
    final CheckModel jsonModel = await ProfileRequest.checkOut();

    if (jsonModel.success == true) {
      emit(CheckOutState());
      User.checkedIn = false;
    } else {
      emit(ProfileErrorState(
          message: jsonModel.message ?? "Неизвестная ошибка"));
    }
  }

  Future<void> _deleteUser(DeleteUser event, Emitter<ProfileState> emit) async {
    await ProfileRequest.deleteUser();
    await TokenRepository.deleteToken();
    User.clear;
    emit(LogoutState());
  }

  void _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    await TokenRepository.deleteToken();
    User.clear;
    emit(LogoutState());
  }
}
