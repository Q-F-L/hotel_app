import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/data/user/user.dart';
import 'package:http/http.dart' as http;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<CreateProfileEvent>(_createProfile);

    on<MoveOutEvent>(_moveOut);
  }

  _createProfile(ProfileEvent event, Emitter emit) async {
    emit(state);
    // if (User.id == null) {
    //   await User.create();
    // }
    print("User.id ${User.id}");
    User.id ?? await User.create();
    print("User.id ${User.id}");
  }

  Future<void> _moveOut(MoveOutEvent event, Emitter<ProfileState> emit) async {
    final tokenRepository = TokenRepository();
    final token = await tokenRepository.getToken();
    final response = await http.get(
      Uri.parse('https://app.successhotel.ru/api/client/check-out'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    final json = jsonDecode(response.body);
    if (response.statusCode == 200 && json['success'] == true) {
      User.checkedIn = false;
    } else {}
  }
}
