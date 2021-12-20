import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/dashboard_provider.dart';

class AddDriverCompletePage extends StatelessWidget {
  const AddDriverCompletePage({Key? key}) : super(key: key);

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
        title: Text("Tambahkan Sopir"),
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
            SizedBox(height: 24),
            Text("Sopir Telah Ditambahkan", style: AppStyle.title1Text),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Provider.of<DashboardProvider>(context, listen: false)
                    .jumpToPage(0);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("Kembali ke Halaman Utama"),
            ),
          ],
        ),
      ),
    );
  }
}
