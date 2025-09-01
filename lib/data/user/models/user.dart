import 'package:m_softer_test_project/data/user/models/profile.dart';
import 'package:m_softer_test_project/data/user/requests.dart';

class User {
  static int? id;
  static String? email;
  static String? firstName;
  static String? lastName;
  static String? middleName;
  static String? phone;
  static String? deviceToken;
  static bool? checkedIn = true;
  static String? fullName;
  static CurrentClientRoom? currentClientRoom;
  static int? ordersCount;
  static int? activeOrdersCount;

  User(Profile profile) {
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

  static Future<void> create() async {
    final ProfileModel profileRequest = await ProfileRequest.profileRequest();

    if (profileRequest.message?.isEmpty ?? true) {
      User(profileRequest.profile ?? Profile());
    }
  }

  static void clear() {
    id = null;
    email = null;
    firstName = null;
    lastName = null;
    middleName = null;
    phone = null;
    deviceToken = null;
    checkedIn = null;
    fullName = null;
    currentClientRoom = null;
    ordersCount = null;
    activeOrdersCount = null;
  }
}
