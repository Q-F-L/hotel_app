import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          SvgPicture.asset(
            "$pathForImage${AppImage.icon}",
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
