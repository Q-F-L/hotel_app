import 'package:flutter/material.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class GradientFloatingActionButton extends StatelessWidget {
  const GradientFloatingActionButton(
      {super.key,
      this.onPressed,
      required this.firstColor,
      required this.secondColor,
      required this.textColor});
  final VoidCallback? onPressed;
  final Color firstColor;
  final Color secondColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: AppColors.shadow,
              blurRadius: 15,
              spreadRadius: 2,
              offset: Offset(0, 8)),
        ],
        gradient: LinearGradient(colors: [firstColor, secondColor]),
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        child: Image.asset(
          "assets/images/services.png",
          color: textColor,
        ),
      ),
    );
  }
}
