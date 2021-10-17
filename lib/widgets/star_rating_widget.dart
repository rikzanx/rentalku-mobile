import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final void Function(double)? onRatingChanged;
  final double size;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    this.size = 32,
    required this.onRatingChanged,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: AppColor.grey,
        size: size,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: AppColor.yellow,
        size: size,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: AppColor.yellow,
        size: size,
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: InkResponse(
        radius: 24,
        onTap:
            onRatingChanged != null ? () => onRatingChanged!(index + 1.0) : null,
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: new List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
      mainAxisSize: MainAxisSize.min,
    );
  }
}
