import 'package:flutter/material.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "— ",
          style: labelSmallManrope,
        ),
        Expanded(
          child: Text(
            text,
            style: labelSmallManrope,
          ),
        ),
      ],
    );
  }
}
