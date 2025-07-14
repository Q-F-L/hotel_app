import 'package:flutter/material.dart';

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
    this.margin = const EdgeInsets.all(16.0),
    this.border,
    this.shadow,
    this.canClick = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: borderRadius,
      child: Opacity(
        opacity: canClick ? 1 : 0.5,
        child: Container(
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
    );
  }
}
