import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/review.dart';
import 'package:rentalku/widgets/star_rating_widget.dart';

class ReviewCardWidget extends StatelessWidget {
  final Review review;

  const ReviewCardWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(review.imageURL),
              radius: 30,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${review.name}",
                    style: AppStyle.regular1Text.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      StarRating(rating: review.rating, size: 16),
                      SizedBox(width: 10),
                      Text(
                        DateFormat("d/M/yy").format(review.dateTime),
                        style: AppStyle.smallText,
                      ),
                    ],
                  ),
                  Text(review.text, style: AppStyle.smallText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
