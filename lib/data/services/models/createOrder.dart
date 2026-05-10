import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) =>
    CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
  final bool? success;
  final String? message;
  final String? confirmationUrl;

  CreateOrderModel({
    this.success,
    this.message,
    this.confirmationUrl,
  });

  CreateOrderModel copyWith({
    bool? success,
    String? message,
    String? confirmationUrl,
  }) =>
      CreateOrderModel(
        success: success ?? this.success,
        message: message ?? this.message,
        confirmationUrl: confirmationUrl ?? this.confirmationUrl,
      );

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
        success: json["success"],
        message: json["message"],
        confirmationUrl: json["confirmation_url"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "confirmation_url": confirmationUrl,
      };
}
