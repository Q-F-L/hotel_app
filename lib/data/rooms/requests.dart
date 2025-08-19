import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/rooms/model.dart';
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class RoomsRequest {
  static Future<RoomsModel> create(int organizationsId) async {
    try {
      final response = await http.get(
        Uri.parse('$urlDomain/api/client/organizations/$organizationsId/rooms'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenRepository.token}'
        },
      );
      final jsonModel = roomsModelFromJson(response.body);

      if (response.statusCode == 200) {
        return jsonModel;
      } else {
        return RoomsModel(
            message: "Ошибка: ${response.statusCode} ${jsonModel.message}");
      }
    } catch (e) {
      return RoomsModel(message: e.toString());
    }
  }
}
