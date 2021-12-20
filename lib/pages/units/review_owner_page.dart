import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/review.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';
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
        title: Text("Penilaian & Ulasan Pemilik"),
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
      body: Consumer<UlasanUnitProvider>(
        builder: (context,state,_){
          if(state.homeState == HomeState.Loading){
            return Center(child: CircularProgressIndicator(color: AppColor.green,),);
          }else if(state.homeState == HomeState.Error){
            return Center(child: Text(defaultErrorText),);
          }
          return Container(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Center(child: StarRating(rating: state.ulasanPemilik!.avgRating)),
            SizedBox(height: 5),
            Text(
              "Rata-Rata Penilaian : ${state.ulasanPemilik!.avgRating.toString()}",
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
              state.ulasanPemilik!.ratingList.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ReviewCardWidget(
                  rating: state.ulasanPemilik!.ratingList.elementAt(index),
                  ),
                ),
              ),
          ],
        ),
      );
        },
      ),
    );
  }
}
