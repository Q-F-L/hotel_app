import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_softer_test_project/elements/show_rating.dart';

import '../themes/themes.dart';

class CardRequest extends StatefulWidget {
  const CardRequest({super.key});

  @override
  State<CardRequest> createState() => _CardRequestState();
}

class _CardRequestState extends State<CardRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey1,
        ),
        boxShadow: [shadow],
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return ShowRating();
              });
        },
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
                      ?.copyWith(fontWeight: FontWeight.normal, fontSize: 18),
                ),
                Text(
                  "отменить",
                  style: labelSmallManrope.copyWith(fontSize: 12),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          "$pathForImage${AppImage.requestComplited}"),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "12:01",
                        style: labelSmallManrope.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Text(
                  "выполнено",
                  style: labelSmallManrope.copyWith(color: AppColors.textGreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
