import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/rental_mobil.dart';

class RentalMobilCard extends StatelessWidget {
  final RentalMobil data;

  const RentalMobilCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp. ",
      decimalDigits: 0,
    );

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image.network(data.imageURL),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: AppStyle.regular1Text.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    data.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.regular1Text,
                  ),
                  Text(
                    data.withDriver ? "Dengan Supir" : "Tanpa Supir",
                    style: AppStyle.smallText,
                  ),
                  Text(
                    "Harga Mulai Dari",
                    style: AppStyle.smallText.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formatCurrency.format(data.price) + "/Hari",
                    style: AppStyle.smallText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.yellow,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 12, color: AppColor.yellow),
                    SizedBox(width: 2),
                    Text(
                      data.rating.toString(),
                      style: AppStyle.smallText,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.people, size: 12, color: AppColor.green),
                    SizedBox(width: 2),
                    Text(
                      data.totalReviews.toString(),
                      style: AppStyle.smallText,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
