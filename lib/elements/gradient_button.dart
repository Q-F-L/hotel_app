import 'package:flutter/material.dart';
import 'package:m_softer_test_project/themes/themes.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Gradient gradient;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final EdgeInsetsGeometry margin;
  bool canClick;
  String errorMessage;

  GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.gradient = const LinearGradient(
      colors: [Color(0xFF53E88B), Color(0xFF15BE77)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    this.borderRadius = BorderRadius.zero,
    this.padding = const EdgeInsets.only(top: 8.0, bottom: 8.0),
    this.margin = const EdgeInsets.all(0.0),
    this.border,
    this.shadow,
    this.canClick = true,
    this.errorMessage = "Заполните данные!",
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: canClick
            ? onPressed
            : () {
                showCustomSnackBar(context, errorMessage);
              },
        borderRadius: borderRadius,
        child: Opacity(
          opacity: canClick ? 1 : 0.5,
          child: Container(
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: borderRadius,
              border: border,
              boxShadow: shadow,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: padding,
                child: Center(
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
