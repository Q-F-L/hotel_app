import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/star_rating.dart';
import 'package:m_softer_test_project/elements/text_input_form.dart';
import 'package:m_softer_test_project/themes/themes.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

import 'bloc/review_bloc.dart';

class ShowRating extends StatelessWidget {
  final int orderId;

  const ShowRating({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewBloc(),
      child: BlocConsumer<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state is ReviewSuccess) {
            Navigator.pop(context);

            showToast(context, state.message ?? "Пустое сообщение",
                focus: WidgetsBinding.instance.window.viewInsets.bottom > 0);
          }

          if (state is ReviewError) {
            showToast(context, state.error ?? "Пустое сообщение",
                focus: WidgetsBinding.instance.window.viewInsets.bottom > 0);
          }
        },
        builder: (context, state) {
          double rating = 3;
          String comment = '';

          if (state is ReviewInitial) {
            rating = state.rating;
            comment = state.comment;
          }

          return SimpleDialog(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            backgroundColor: AppColors.white,
            title: Text(
              'Оцените качество\nвыполненной работы',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            children: <Widget>[
              StarRating(
                size: 40,
                onRatingChanged: (value) {
                  context.read<ReviewBloc>().add(
                    ChangeRatingEvent(value),
                  );
                },
                color: AppColors.lightYellow,
                starCount: 5,
                rating: rating,
              ),
              SizedBox(height: 20),
              TextInputForm(
                hintText: "Комментарий",
                onChanged: (value) {
                  context.read<ReviewBloc>().add(
                    ChangeCommentEvent(value),
                  );
                },
              ),
              SizedBox(height: 20),
              GradientButton(
                onPressed: state is ReviewLoading
                    ? null
                    : () {
                  context.read<ReviewBloc>().add(
                    SendReviewEvent(orderId),
                  );
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                child: state is ReviewLoading
                    ? CircularProgressIndicator(
                  color: Colors.white,
                )
                    : Text(
                  "Готово",
                  style: whiteTextButton,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}