import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.onPress,
  });

  final String image;
  final String description;
  final String textButton;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          Image.asset("$pathForImage${AppImage.icon}"),
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
              onPressed: onPress ??
                  () => context.read<ShowerNewPageBloc>().add(NewPage()),
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
