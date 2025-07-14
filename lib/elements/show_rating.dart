import 'package:flutter/material.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/text_input_form.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import 'star_rating.dart';

class ShowRating extends StatefulWidget {
  const ShowRating({super.key});

  @override
  State<ShowRating> createState() => _ShowRatingState();
}

class _ShowRatingState extends State<ShowRating> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      backgroundColor: AppColors.white,
      title: Text(
        'Оцените качество\nвыполненной работы',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      children: <Widget>[
        StarRating(
          size: 40,
          onRatingChanged: (rating) {},
          color: AppColors.lightYellow,
          starCount: 5,
          rating: 3.5,
        ),
        SizedBox(
          height: 20,
        ),
        TextInputForm(
          hintText: "Комментарий",
        ),
        SizedBox(
          height: 20,
        ),
        GradientButton(
          onPressed: () {},
          canClick: true,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Text(
            "Готово",
            style: whiteTextButton,
          ),
        ),
      ],
    );
  }
}
