import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static String _token = '';
  static const _tokenKey = 'auth_token';

  static String get token => _token;

  static Future<void> saveToken(String token) async {
    print("token $token");
    if (token.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    }
  }

  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey) ?? '';
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    _token = '';
  }
}
