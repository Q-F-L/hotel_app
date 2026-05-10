import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_softer_test_project/data/services/models/order.dart';
import 'package:m_softer_test_project/elements/show_rating/show_rating.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import 'show_cancel/show_cancel.dart';

class CardRequest extends StatelessWidget {
  final Order order;

  const CardRequest({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {

    final bool isCompleted = order.status == 3;
    final bool isCanceled = order.status == 2;
    Widget statusIcon() {
      //Отменен
      if(order.status == 2) {
        return SvgPicture.asset(
          "$pathForImage${AppImage.requestNotAccepted}",
        );
      }
      //Выполнен
      if(order.status == 3) {
        return SvgPicture.asset(
          "$pathForImage${AppImage.requestComplited}",
        );
      }
      //В обработке (== 1)
      return SvgPicture.asset(
        "$pathForImage${AppImage.requestInProcesses}",
      );
    }

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey1,
        ),
        boxShadow: [shadow],
        color: AppColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),

        onTap: () {

          if (isCompleted) {
            showDialog(
              context: context,
              builder: (context) {
                return ShowRating(orderId: order.id ?? -1,);
              },
            );
          } else if(!isCanceled) {
            showDialog(
              context: context,
              builder: (context) {
                return ShowCancel(orderId: order.id ?? -1,);
              },
            );
          }
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Text(
                    order.service?.name ?? "Без названия",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),

                isCompleted ? SizedBox() : Text(
                  isCanceled ? "отменено" : "отменить",
                  style: labelSmallManrope.copyWith(
                    fontSize: 12,
                    color: isCanceled
                        ? Colors.red
                        : AppColors.black,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [

                    statusIcon(),
                    const SizedBox(width: 8),

                    Text(
                      order.createdAt?.substring(11, 16) ?? "--:--",
                      style: labelSmallManrope.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                Text(
                  isCompleted
                      ? "выполнено"
                      : isCanceled
                      ? "отменено"
                      : "в обработке",

                  style: labelSmallManrope.copyWith(
                    color: isCompleted
                        ? AppColors.textGreen
                        : isCanceled
                        ? Colors.red
                        : Colors.orange,
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