import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  final bool? success;
  final String? error;
  final String? message;

  RegistrationModel({
    this.success,
    this.error,
    this.message,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        success: json["success"],
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
      };
}
