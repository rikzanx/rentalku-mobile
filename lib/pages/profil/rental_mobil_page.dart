import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/rental_mobil.dart';
import 'package:rentalku/widgets/rental_mobil_card_widget.dart';

class RentalMobilPage extends StatelessWidget {
  const RentalMobilPage({Key? key}) : super(key: key);

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
        title: Text("Rental Mobil"),
        titleTextStyle: AppStyle.title2Text.copyWith(color: Colors.white),
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
        padding: EdgeInsets.only(top: 16, bottom: 24),
        child: Column(
          children: List.generate(
            6,
            (i) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: RentalMobilCard(
                data: RentalMobil(
                  id: 1,
                  name: "Toyota Avanza",
                  description: "Mini MPV",
                  withDriver: true,
                  imageURL: 'https://i.imgur.com/vtUhSMq.png',
                  price: 280000,
                  rating: 4.2,
                  totalReviews: 6,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
