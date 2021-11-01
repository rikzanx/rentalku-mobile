import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final int starCount;
  final void Function(double)? onRatingChanged;

  StarRating({
    this.onRatingChanged,
    this.rating = .0,
    this.size = 32,
    this.starCount = 5,
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
      padding: EdgeInsets.only(left: index == 0 ? 0 : size / 4),
      child: InkResponse(
        radius: 24,
        onTap: onRatingChanged != null
            ? () => onRatingChanged!(index + 1.0)
            : null,
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
