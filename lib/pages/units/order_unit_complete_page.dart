import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/dashboard_provider.dart';

class OrderUnitCompletePage extends StatelessWidget {
  const OrderUnitCompletePage({Key? key}) : super(key: key);

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
        title: Text("Pemesanan"),
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/order_completed.png",
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            SizedBox(height: 5),
            Text(
              "Saldo DompetKu Anda Otomatis telah terpotong",
              style: AppStyle.tinyText,
            ),
            SizedBox(height: 14),
            Text("Lihat Pesananku", style: AppStyle.title1Text),
            Text(
              "jika ingin melihat pesanan anda lebih banyak",
              style: AppStyle.regular1Text,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .jumpToPage(1);
                Navigator.pop(context);
              },
              child: Text("Lihat Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}
