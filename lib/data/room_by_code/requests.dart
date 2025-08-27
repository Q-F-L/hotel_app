import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/room_by_code/model.dart';
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/utils/constants.dart';

class RoomByCodeRequest {
  //Обрабатывает запрос на отравку QrCode
  static Future<RoomByCodeModel> send(String code) async {
    try {
      final response = await http.post(
        Uri.parse('$urlDomain/api/client/room-by-code'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
        body: jsonEncode({"code": code}),
      );
      print("response.body");
      print(response.body);
      final RoomByCodeModel jsonModel = roomByCodeModelFromJson(response.body);
      print("jsonModel.success ${jsonModel.success}");
      return jsonModel;
    } catch (e) {
      print(e);
      return RoomByCodeModel(error: e.toString());
    }
  }
}
