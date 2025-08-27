import 'dart:convert';

CheckModel checkModelFromJson(String str) =>
    CheckModel.fromJson(json.decode(str));

String checkModelToJson(CheckModel data) => json.encode(data.toJson());

class CheckModel {
  final bool? success;
  final String? message;
  final String? error;

  CheckModel({
    this.success,
    this.message,
    this.error,
  });

  factory CheckModel.fromJson(Map<String, dynamic> json) => CheckModel(
        success: json["success"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "error": error,
      };
}
