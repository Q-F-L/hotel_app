import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/themes.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    width: min(message.length * 13, MediaQuery.of(context).size.width * 0.8),
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: const [shadow],
        borderRadius: BorderRadius.circular(6),
        color: AppColors.white,
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.center,
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
