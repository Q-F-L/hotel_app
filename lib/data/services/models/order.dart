import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final bool? success;
  final String? message;
  final String? confirmationUrl;

  OrderModel({
    this.success,
    this.message,
    this.confirmationUrl,
  });

  OrderModel copyWith({
    bool? success,
    String? message,
    String? confirmationUrl,
  }) =>
      OrderModel(
        success: success ?? this.success,
        message: message ?? this.message,
        confirmationUrl: confirmationUrl ?? this.confirmationUrl,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
