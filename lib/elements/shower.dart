import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';

import '../pages/shower_new_page/bloc/shower_new_page_bloc.dart';
import '../themes/themes.dart';

class Shower extends StatelessWidget {
  const Shower({
    super.key,
    required this.image,
    required this.description,
    required this.textButton,
  });

  final String image;
  final String description;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          Image.asset("assets/images/logo_mini.png"),
          Image.asset(image),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Philosopher",
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 40),
            child: GradientButton(
              canClick: true,
              onPressed: () => context.read<ShowerNewPageBloc>().add(NewPage()),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 40.0),
              child: Text(
                textButton,
                style: whiteTextButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
