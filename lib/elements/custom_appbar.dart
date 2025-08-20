import 'package:flutter/material.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.preferredSize,
    required this.title,
  });

  final String title;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Image.asset(
            '$pathForImage${AppImage.icon}',
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
