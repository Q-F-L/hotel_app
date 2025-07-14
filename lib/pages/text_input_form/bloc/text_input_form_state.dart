part of 'text_input_form_bloc.dart';

class TextInputState {
  final String value;
  final bool isPassword;
  final bool obscureText;
  final String? error;

  TextInputState({
    required this.value,
    required this.isPassword,
    required this.obscureText,
    this.error,
  });

  TextInputState copyWith({
    String? value,
    bool? isPassword,
    bool? obscureText,
    String? error,
  }) {
    return TextInputState(
      value: value ?? this.value,
      isPassword: isPassword ?? this.isPassword,
      obscureText: obscureText ?? this.obscureText,
      error: error ?? this.error,
    );
  }
}
