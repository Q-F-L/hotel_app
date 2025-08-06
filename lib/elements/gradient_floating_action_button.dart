import 'package:flutter/material.dart';

class GradientFloatingActionButton extends StatelessWidget {
  const GradientFloatingActionButton(
      {super.key,
      this.onPressed,
      required this.firstColor,
      required this.secondColor});
  final VoidCallback? onPressed;
  final Color firstColor;
  final Color secondColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [firstColor, secondColor]),
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: onPressed,
        child: Image.asset("assets/images/services.png"),
      ),
    );
  }
}
