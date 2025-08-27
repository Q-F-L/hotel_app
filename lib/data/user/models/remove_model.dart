import 'dart:convert';

RemoveProfileModel removeProfileModelFromJson(String str) =>
    RemoveProfileModel.fromJson(json.decode(str));

String removeProfileModelToJson(RemoveProfileModel data) =>
    json.encode(data.toJson());

class RemoveProfileModel {
  final bool? success;
  final String? message;

  RemoveProfileModel({
    this.success,
    this.message,
  });

  factory RemoveProfileModel.fromJson(Map<String, dynamic> json) =>
      RemoveProfileModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
