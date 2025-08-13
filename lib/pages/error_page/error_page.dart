import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          errorMessage ?? "ErrorMessage содержит null. Непредвиденная ошибка",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
    ;
  }
}
