import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m_softer_test_project/data/token.dart';
import 'package:m_softer_test_project/data/user/profile.dart';

class User {
  static int? _id;
  static String? _email;
  static String? _firstName;
  static String? _lastName;
  static String? _middleName;
  static String? _phone;
  static String? _deviceToken;
  static bool? _checkedIn;
  static String? _fullName;
  static CurrentClientRoom? _currentClientRoom;
  static int? _ordersCount;
  static int? _activeOrdersCount;

  // Геттеры
  static int? get id => _id;
  static String? get email => _email;
  static String? get firstName => _firstName;
  static String? get lastName => _lastName;
  static String? get middleName => _middleName;
  static String? get phone => _phone;
  static String? get deviceToken => _deviceToken;
  static bool? get checkedIn => _checkedIn;
  static String? get fullName => _fullName;
  static CurrentClientRoom? get currentClientRoom => _currentClientRoom;
  static int? get ordersCount => _ordersCount;
  static int? get activeOrdersCount => _activeOrdersCount;

  // Сеттеры
  static set id(int? value) => _id = value;
  static set email(String? value) => _email = value;
  static set firstName(String? value) => _firstName = value;
  static set lastName(String? value) => _lastName = value;
  static set middleName(String? value) => _middleName = value;
  static set phone(String? value) => _phone = value;
  static set deviceToken(String? value) => _deviceToken = value;
  static set checkedIn(bool? value) => _checkedIn = value;
  static set fullName(String? value) => _fullName = value;
  static set currentClientRoom(CurrentClientRoom? value) =>
      _currentClientRoom = value;
  static set ordersCount(int? value) => _ordersCount = value;
  static set activeOrdersCount(int? value) => _activeOrdersCount = value;

  static void create(Profile profile) {
    User.id = profile.id;
    User.email = profile.email;
    User.firstName = profile.firstName;
    User.lastName = profile.lastName;
    User.middleName = profile.middleName;
    User.phone = profile.phone;
    User.deviceToken = profile.deviceToken;
    User.checkedIn = profile.checkedIn;
    User.fullName = profile.fullName;
    User.currentClientRoom = profile.currentClientRoom;
    User.ordersCount = profile.ordersCount;
    User.activeOrdersCount = profile.activeOrdersCount;
  }

  static Future<void> request() async {
    final tokenRepository = TokenRepository();
    final token = await tokenRepository.getToken();
    final response = await http.get(
      Uri.parse('https://app.successhotel.ru/api/client/profile'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final ProfileRequest profileRequest = ProfileRequest.fromJson(json);
      User.create(profileRequest.profile ?? Profile());
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  // Только для проверки заселения пользователя в номер отеля
  Future<bool> userCheckIn() async {
    final response = await http.post(
      Uri.parse('https://app.successhotel.ru/api/client/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final ProfileRequest profileRequest = ProfileRequest.fromJson(json);
      return profileRequest.profile?.checkedIn ?? false;
    } else {
      return false;
    }
  }

  static void clear() {
    _id = null;
    _email = null;
    _firstName = null;
    _lastName = null;
    _middleName = null;
    _phone = null;
    _deviceToken = null;
    _checkedIn = null;
    _fullName = null;
    _currentClientRoom = null;
    _ordersCount = null;
    _activeOrdersCount = null;
  }
}
