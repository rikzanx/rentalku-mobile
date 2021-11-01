import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/article.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/widgets/article_card_widget.dart';
import 'package:rentalku/widgets/balance_widget.dart';

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 48),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset("assets/images/rentalku.png", height: 16),
          ),
          SizedBox(height: 8),
          Consumer<AppProvider>(
            builder: (context, app, _) => app.isUser
                ? UserInfo(context)
                : app.isOwner
                    ? OwnerInfo(context)
                    : Container(),
          ),
          SizedBox(height: 12),
          Container(
            height: 6,
            color: AppColor.grey,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "Artikel",
              style: AppStyle.regular1Text.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: ArticleCardWidget(
                article: Article(
                  id: 1,
                  title: "Enam Teknik Mencuci Mobil yang Benar, Jangan Asal!",
                  category: "Otomotif",
                  imageURL: "https://i.imgur.com/9waAALi.jpg",
                  webURL: "http://id.wikipedia.org/wiki/Rantai_blok",
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget UserInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nama User
              Expanded(
                flex: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo,",
                      style: AppStyle.regular1Text,
                    ),
                    Text(
                      "Muhammad",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Saldo
              Expanded(
                flex: 55,
                child: BalanceWidget(
                  balance: 500000,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.topUp);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Form(
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Cari di RentalKu",
                        hintStyle: AppStyle.smallText.copyWith(
                          color: Colors.black,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                      ),
                      textInputAction: TextInputAction.search,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom username wajib diisi';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(4, 4, 8, 4),
                    child: Icon(Icons.search, size: 16),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                elevation: 1,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 56) / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(4, 12, 4, 4),
                      child: Column(
                        children: [
                          Image.network("https://i.imgur.com/vtUhSMq.png"),
                          SizedBox(height: 4),
                          Text("Lihat serupa", style: AppStyle.tinyText),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget OwnerInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nama User
              Expanded(
                flex: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo,",
                      style: AppStyle.regular1Text,
                    ),
                    Text(
                      "Muhammad",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Saldo
              Expanded(
                flex: 55,
                child: BalanceWidget(
                  balance: 500000,
                  actionName: "Tarik",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.withdraw);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Form(
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(4, 4, 8, 4),
                    child: Icon(Icons.location_pin, size: 16),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(text: "Surabaya"),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                      ),
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColor.green),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.white,
                  elevation: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -6,
                          left: -6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.green,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.directions_car,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -10,
                          top: -25,
                          child: Icon(
                            Icons.directions_car,
                            color: AppColor.lightGreen,
                            size: 108,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          alignment: Alignment.center,
                          child: Text(
                            "Galeri Unitku",
                            style: AppStyle.regular2Text,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.myUnits);
                    },
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColor.green),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.white,
                  elevation: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -6,
                          left: -6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.green,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -10,
                          top: -25,
                          child: Icon(
                            Icons.add_circle_outline,
                            color: AppColor.lightGreen,
                            size: 108,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          alignment: Alignment.center,
                          child: Text(
                            "Tambah Unit Rental",
                            style: AppStyle.regular2Text,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.addUnit);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
