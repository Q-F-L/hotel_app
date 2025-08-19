import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/organizations/model.dart';
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class OrganizationsRequest {
  static Future<Hotel> create() async {
    try {
      final response = await http.get(
        Uri.parse('$urlDomain/api/client/organizations'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
      );
      final jsonModel = hotelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return Hotel(
            message: "Ошибка: ${response.statusCode} ${jsonModel.message}");
      }
    } catch (e) {
      return Hotel(message: e.toString());
    }
  }
}
