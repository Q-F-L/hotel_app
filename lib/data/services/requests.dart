import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/services/models/cancel_order_model.dart';
import 'package:m_softer_test_project/data/services/models/createOrder.dart';
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/utils/constants.dart';

import 'models/order.dart';
import 'models/review.dart';
import 'models/services.dart';

class ServicesRequest {
  static Future<CancelOrderModel> cancelOrder({
    required int orderId,
    required String comment,
  }) async {
    final response = await http.post(
      Uri.parse('$urlDomain/api/client/orders/$orderId/cancel'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${TokenRepository.token}',
      },
      body: jsonEncode({
        "comment": comment,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return CancelOrderModel.fromJson(data);
    } else {
      throw Exception(
        data['error'] ?? 'Ошибка отмены заказа',
      );
    }
  }

  static Future<ReviewResponse> sendReview({
    required int orderId,
    required String comment,
    required int rating,
  }) async {
    final response = await http.post(
      Uri.parse('$urlDomain/api/client/orders/$orderId/review'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${TokenRepository.token}',
      },
      body: jsonEncode({
        "comment": comment,
        "rating": rating,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(data);
    } else {
      throw Exception(data['error'] ?? 'Ошибка отправки отзыва');
    }
  }

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

  static Future<CreateOrderModel> createOreder(
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
      final jsonModel = createOrderModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return CreateOrderModel(
            message: "Ошибка: ${response.statusCode} ${jsonModel.message}");
      }
    } catch (e) {
      return CreateOrderModel(message: e.toString());
    }
  }

  static Future<OrderModel> orders() async {
    try {
      final response = await http.get(
        Uri.parse('$urlDomain/api/client/orders'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
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
