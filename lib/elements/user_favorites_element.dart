import 'package:flutter/material.dart';

import '../themes/themes.dart';

class UserFavoritesElement extends StatelessWidget {
  const UserFavoritesElement(
      {super.key, this.unorderedList, required this.name, required this.icon});
  final List<String>? unorderedList;
  final String name;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset("assets/images/sleap_bad.png"),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Philosopher",
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "изменить",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          UnorderedListItem(unorderedList?[0]),
          SizedBox(
            height: 10,
          ),
          UnorderedListItem(unorderedList?[1]),
        ],
      ),
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key});
  final String? text;

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
            text ?? 'null',
            style: labelSmallManrope,
          ),
        ),
      ],
    );
  }
}
