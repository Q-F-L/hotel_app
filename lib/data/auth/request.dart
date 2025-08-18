import 'dart:convert';

import 'package:http/http.dart' as http;

import 'registration_model.dart';
import 'token_model.dart';

class AuthRequest {
  static Future<MyFeedbackListModel> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://app.successhotel.ru/api/client/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final jsonModel = myFeedbackListModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return MyFeedbackListModel(
            error: jsonModel.error ??
                "Неизвестная ошибка: ${response.statusCode}");
      }
    } catch (e) {
      return MyFeedbackListModel(error: e.toString());
    }
  }

  static Future<RegistrationModel> registration(
      String name, String surname, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://app.successhotel.ru/api/client/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firstName': name,
          'lastName': surname,
          'email': email,
          'password': password,
          'confirmPassword': password,
          'guard': 'client',
        }),
      );

      final jsonModel = registrationModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return RegistrationModel(
          error:
              jsonModel.error ?? "Неизвестная ошибка: ${response.statusCode}",
          message: jsonModel.message,
        );
      }
    } catch (e) {
      return RegistrationModel(error: e.toString());
    }
  }

  // Пока нет FireBase
  static Future<void> sendFcmToken(String authToken, String fcmToken) async {
    try {
      await http.post(
        Uri.parse('https://app.successhotel.ru/api/profile/fcm-token'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'device_token': fcmToken,
        }),
      );
    } catch (e) {
      print(e);
    }
  }
}
