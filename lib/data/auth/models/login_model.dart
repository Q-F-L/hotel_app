import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? token;
  bool? status;
  String? error;

  LoginModel({this.token, this.status, this.error});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        status: json["success"],
        error: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "success": status,
        "message": error,
      };
}
