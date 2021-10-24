import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/transaction.dart';
import 'package:rentalku/widgets/transaction_card_widget.dart';

class DompetkuPage extends StatelessWidget {
  const DompetkuPage({Key? key}) : super(key: key);

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
        title: Text("Dompetku"),
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
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppColor.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jumlah Saldo",
                          style: AppStyle.title3Text.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          Helper.toIDR(500000),
                          style: AppStyle.regular1Text.copyWith(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                      child: Text("Top Up"),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.topUp);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        primary: Colors.white,
                        onPrimary: AppColor.green,
                        padding: EdgeInsets.all(0),
                        visualDensity: VisualDensity.compact,
                        textStyle: AppStyle.regular1Text.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  "Transaksi Terakhir",
                  style: AppStyle.title3Text.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ...List.generate(
                10,
                (index) => TransactionCardWidget(
                  transaction: Transaction(
                    id: 1,
                    title: "Pembayaran",
                    description: "Toyota Avanza",
                    dateTime: DateTime.now(),
                    amount: 280000,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
