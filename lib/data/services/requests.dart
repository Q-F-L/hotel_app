import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/services/models/order.dart';
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/utils/constants.dart';

import 'models/services.dart';

class ServicesRequest {
  static Future<ServicesModel> create() async {
    try {
      final response = await http.get(
        Uri.parse('$urlDomain/api/client/services'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
      );
      final jsonModel = servicesModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return ServicesModel(
            message: "Ошибка: ${response.statusCode} ${jsonModel.message}");
      }
    } catch (e) {
      return ServicesModel(message: e.toString());
    }
  }

  static Future<OrderModel> createOreder(
      int serviceId, List<Options> options) async {
    try {
      final response = await http.post(
        Uri.parse('$urlDomain/api/client/orders/create'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
        body: jsonEncode({
          "service_id": serviceId,
          "comment": "Комментарий",
          "options": options
        }),
      );
      final jsonModel = orderModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return OrderModel(
            message: "Ошибка: ${response.statusCode} ${jsonModel.message}");
      }
    } catch (e) {
      return OrderModel(message: e.toString());
    }
  }
}
