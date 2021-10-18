import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
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
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Image.asset("assets/images/rentalku.png", height: 16),
          ),
          Consumer<AppProvider>(
            builder: (context, app, _) =>
                app.isUser ? UserInfo(context) : Container(),
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
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
                child: BalanceWidget(balance: 500000),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
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
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
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
        ),
      ],
    );
  }
}
