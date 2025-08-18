import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/data/user/profile.dart';

class ProfileRequest {
  static Future<ProfileModel> request() async {
    print("create request USER");
    try {
      final response = await http.get(
        Uri.parse('https://app.successhotel.ru/api/client/profile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
      );

      final jsonModel = profileRequestFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return ProfileModel(message: "Неизвестная ошибка");
      }
    } catch (e) {
      return ProfileModel(message: e.toString());
    }
  }
}
