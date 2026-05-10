import 'dart:convert';

class ReviewResponse {
  final String message;
  final String error;
  final bool success;

  ReviewResponse({
    required this.message,
    required this.error,
    required this.success,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      message: json['message'] ?? '',
      error: json['error'] ?? '',
      success: json['success'] ?? false,
    );
  }
}