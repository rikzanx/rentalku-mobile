import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/rental_mobil.dart';
import 'package:rentalku/widgets/star_rating_widget.dart';

class DetailRentalMobilPage extends StatelessWidget {
  const DetailRentalMobilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RentalMobil rentalMobil = RentalMobil(
      id: 1,
      name: "Toyota Avanza",
      description: "Mini MPV",
      withDriver: true,
      imageURL: 'https://i.imgur.com/vtUhSMq.png',
      price: 280000,
      rating: 4.2,
      capacity: 6,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Detail Produk"),
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
            Material(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      rentalMobil.imageURL,
                      height: MediaQuery.of(context).size.width * 0.25,
                    ),
                    SizedBox(height: 16),
                    Text(
                      rentalMobil.name,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      rentalMobil.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.regular1Text,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      Helper.toIDR(rentalMobil.price) + "/Hari",
                      style: AppStyle.smallText.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.yellow,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "Review",
                          style: AppStyle.regular2Text.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${rentalMobil.rating}/5",
                          style: AppStyle.regular2Text,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StarRating(rating: rentalMobil.rating, size: 20),
                        SizedBox(width: 10),
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                            child: Text(
                              "Lihat semua ulasan",
                              style: AppStyle.smallText.copyWith(
                                color: AppColor.green,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.reviewProduct);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lihat Penilaian Pemilik Mobil",
                            style: AppStyle.regular1Text.copyWith(
                              color: AppColor.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Ink(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.green.withOpacity(0.5),
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: AppColor.green,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.reviewOwner);
                      },
                    ),
                    SizedBox(height: 16),
                    Divider(thickness: 2, color: Colors.grey[500]),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.people,
                                color: AppColor.green,
                              ),
                              Text(
                                "6 Penumpang",
                                style: AppStyle.smallText.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.person,
                                color: AppColor.green,
                              ),
                              Text(
                                "Tanpa Sopir",
                                style: AppStyle.smallText.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.directions_car,
                                color: AppColor.green,
                              ),
                              Text(
                                "Tahun 2018",
                                style: AppStyle.smallText.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 2, color: Colors.grey[500]),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.directions_car,
                            size: 20, color: AppColor.green),
                        SizedBox(width: 5),
                        Text(
                          "Transmisi",
                          style: AppStyle.regular2Text,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.directions_car,
                            size: 20, color: AppColor.green),
                        SizedBox(width: 5),
                        Text(
                          "Mesin 1998cc",
                          style: AppStyle.regular2Text,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.directions_car,
                            size: 20, color: AppColor.green),
                        SizedBox(width: 5),
                        Text(
                          "6 Penumpang",
                          style: AppStyle.regular2Text,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.directions_car,
                            size: 20, color: AppColor.green),
                        SizedBox(width: 5),
                        Text(
                          "Warna Silver",
                          style: AppStyle.regular2Text,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.directions_car,
                            size: 20, color: AppColor.green),
                        SizedBox(width: 5),
                        Text(
                          "Tahun 2021",
                          style: AppStyle.regular2Text,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text("Lanjut ke Pemesanan"),
              onPressed: () {
                Navigator.pushNamed(context, Routes.rentalMobilOrder);
              },
            ),
          ],
        ),
      ),
    );
  }
}
