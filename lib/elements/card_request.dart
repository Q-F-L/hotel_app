import 'package:flutter/material.dart';
import 'package:m_softer_test_project/elements/show_rating.dart';

import '../themes/themes.dart';

class CardRequest extends StatefulWidget {
  const CardRequest({super.key});

  @override
  State<CardRequest> createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {
  var stateIconMap = <String, String>{
    'complated': 'check_mark',
    'inProcess': 'time_mark',
    'unaccepted': 'grey_time_mark'
  };

  String state = 'inProcess';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return ShowRating();
            });
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 8), // changes position of shadow
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Уборка номера",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
                Text(
                  "отменить",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Image.asset("assets/images/${stateIconMap[state]}.png"),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "12:01",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  "выполнено",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textGreen,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
