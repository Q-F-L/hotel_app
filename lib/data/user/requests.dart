import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/data/user/models/check_model.dart';
import 'package:m_softer_test_project/data/user/models/profile.dart';
import 'package:m_softer_test_project/data/user/models/remove_model.dart';
import 'package:m_softer_test_project/utils/constants.dart';

class ProfileRequest {
  static Future<ProfileModel> profileRequest() async {
    try {
      final response = await http.get(
        Uri.parse('$urlDomain/api/client/profile'),
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

  static Future<CheckModel> checkOut() async {
    try {
      final response = await http.get(
        Uri.parse('$urlDomain/api/client/check-out'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
      );

      final jsonModel = checkModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return CheckModel(message: "Ошибка: ${response.statusCode}");
      }
    } catch (e) {
      return CheckModel(message: e.toString());
    }
  }

  static Future<CheckModel> checkIn(int roomId, String date) async {
    try {
      final response = await http.post(
        Uri.parse('$urlDomain/api/client/check-in'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
        body: jsonEncode({
          'room_id': roomId,
          'chek_in_date': date,
        }),
      );

      final jsonModel = checkModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return CheckModel(message: "Ошибка: ${response.statusCode}");
      }
    } catch (e) {
      return CheckModel(message: e.toString());
    }
  }

  static Future<RemoveProfileModel> deleteUser() async {
    try {
      final response = await http.get(
        Uri.parse('$urlDomain/api/client/check-out'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
      );

      final RemoveProfileModel jsonModel =
          removeProfileModelFromJson(response.body);

      return jsonModel;
    } catch (e) {
      return RemoveProfileModel(message: e.toString());
    }
  }
}
