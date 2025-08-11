import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/data/user/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    // on<MoveOutEvent>(_moveOut);
  }

  // Future<void> _moveOut(MoveOutEvent event, Emitter<ProfileState> emit) async {
  //   final tokenRepository = TokenRepository();
  //   final token = await tokenRepository.getToken();
  //   final response = await http.get(
  //     Uri.parse('https://app.successhotel.ru/api/client/check-out'),
  //     headers: {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );

  //   final json = jsonDecode(response.body);
  //   if (response.statusCode == 200 && json['success'] == true) {
  //     User.checkedIn = false;
  //   } else {}
  // }
}
