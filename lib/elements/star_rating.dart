import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatefulWidget {
  StarRating(
      {super.key,
      this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      required this.color,
      required this.size});

  final int starCount;
  final double? size;
  double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color color;
  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  Widget buildStar(BuildContext context, int index) {
    Icon icon;

    if (index >= widget.rating) {
      icon = Icon(
        shadows: [
          Shadow(
            color: widget.color,
            offset: Offset(0, 0),
            blurRadius: 70,
          ),
        ],
        size: widget.size,
        Icons.star_border,
        color: widget.color,
      );
    } else if (index > widget.rating - 1 && index < widget.rating) {
      icon = Icon(
        shadows: [
          Shadow(
            color: widget.color,
            offset: Offset(0, 0),
            blurRadius: 70,
          ),
        ],
        size: widget.size,
        Icons.star_half,
        color: widget.color,
      );
    } else {
      icon = Icon(
        shadows: [
          Shadow(
            color: widget.color,
            offset: Offset(0, 0),
            blurRadius: 70,
          ),
        ],
        size: widget.size,
        Icons.star,
        color: widget.color,
      );
    }
    return InkResponse(
      onTap: () {
        setState(() {
          widget.rating = index + 1;
        });
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
