import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/review.dart';
import 'package:rentalku/widgets/review_card_widget.dart';
import 'package:rentalku/widgets/star_rating_widget.dart';

class ReviewOwnerPage extends StatelessWidget {
  const ReviewOwnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Penilaian & Ulasan Pemilik Mobil"),
        titleTextStyle: AppStyle.title3Text.copyWith(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: StarRating(rating: 4)),
            SizedBox(height: 5),
            Text(
              "Rata-Rata Penilaian : 4.2",
              style: AppStyle.smallText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              "Ulasan Pelanggan",
              style: AppStyle.regular1Text.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            ...List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ReviewCardWidget(
                  review: Review(
                    id: 1,
                    name: "Ahmad Ujang",
                    imageURL: "https://lorempixel.com/200/200/people/",
                    rating: 4,
                    text:
                        "pelayanannya driver nya sabar cara mengemudikan sangat hati",
                    dateTime: DateTime.now().subtract(
                      Duration(days: Random().nextInt(10)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
