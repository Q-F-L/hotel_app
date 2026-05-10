import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/utils/constants.dart';

class OrederRequests {
  // Оставлю так пока нет 200 ответа от сервера
  Future<void> review({String? comment, String? rating}) async {
    final response = await http.post(
      Uri.parse('$urlDomain/api/client/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'comment': comment,
        'rating': rating,
      }),
    );
  }
}
