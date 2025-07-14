import 'package:flutter/material.dart';
import 'package:m_softer_test_project/themes/themes.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  const StarRating(
      {super.key,
      this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      required this.color,
      required this.size});

  final int starCount;
  final double? size;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color color;

  Widget buildStar(BuildContext context, int index) {
    Icon icon;

    if (index >= rating) {
      icon = Icon(
        shadows: [
          Shadow(
            color: color,
            offset: Offset(0, 0),
            blurRadius: 70,
          ),
        ],
        size: size,
        Icons.star_border,
        color: color,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        shadows: [
          Shadow(
            color: color,
            offset: Offset(0, 0),
            blurRadius: 70,
          ),
        ],
        size: size,
        Icons.star_half,
        color: color,
      );
    } else {
      icon = Icon(
        shadows: [
          Shadow(
            color: color,
            offset: Offset(0, 0),
            blurRadius: 70,
          ),
        ],
        size: size,
        Icons.star,
        color: color,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
