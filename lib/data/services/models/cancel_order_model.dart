class CancelOrderModel {
  final String message;
  final String error;
  final bool success;

  CancelOrderModel({
    required this.message,
    required this.error,
    required this.success,
  });

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) {
    return CancelOrderModel(
      message: json['message'] ?? '',
      error: json['error'] ?? '',
      success: json['success'] ?? false,
    );
  }
}