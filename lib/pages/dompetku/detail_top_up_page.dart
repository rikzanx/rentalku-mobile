import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/strings.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/payment_method.dart';
import 'package:rentalku/models/top_up.dart';

class DetailTopUpPage extends StatelessWidget {
  const DetailTopUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TopUp topUp = TopUp(
        id: 1,
        amount: 500000,
        uniqueCode: 123,
        paymentMethod: PaymentMethod.list.first);
    String amount = Helper.toIDR(topUp.totalAmount);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Detail Top Up"),
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
        padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Transfer ke Nomor Rekening",
              style: AppStyle.regular2Text.copyWith(
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Image.asset(
                  "assets/logos/" + topUp.paymentMethod.imageURL,
                  height: 20,
                ),
                SizedBox(width: 12),
                Text(
                  topUp.paymentMethod.accountNumber,
                  style: AppStyle.regular1Text.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  splashColor: AppColor.green.withOpacity(0.2),
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: topUp.paymentMethod.accountNumber),
                    ).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tersalin di papan klip'),
                      ));
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Icon(Icons.copy, size: 12, color: AppColor.green),
                        SizedBox(width: 4),
                        Text(
                          "Salin",
                          style: AppStyle.smallText.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              topUp.paymentMethod.shortName +
                  " a/n " +
                  topUp.paymentMethod.accountName,
              style: AppStyle.regular1Text,
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.75),
                  width: 0.5,
                ),
              ),
              child: Text(
                AppString.infoTransfer,
                style: AppStyle.smallText,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Jumlah yang harus di transfer",
              style: AppStyle.regular2Text.copyWith(
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: amount.substring(0, amount.length - 3),
                        style: AppStyle.display1Text,
                      ),
                      TextSpan(
                        text: amount.substring(amount.length - 3),
                        style: AppStyle.display1Text.copyWith(
                          color: AppColor.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  splashColor: AppColor.green.withOpacity(0.2),
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: topUp.totalAmount.toString()),
                    ).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tersalin di papan klip'),
                      ));
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Icon(Icons.copy, size: 12, color: AppColor.green),
                        SizedBox(width: 4),
                        Text(
                          "Salin",
                          style: AppStyle.smallText.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.75),
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_rounded, color: AppColor.yellow, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppString.titleKodeUnik,
                          style: AppStyle.smallText.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          AppString.subtitleKodeUnik,
                          style: AppStyle.smallText.copyWith(
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Rincian Jumlah",
              style: AppStyle.regular2Text.copyWith(
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jumlah Transfer",
                  style: AppStyle.regular2Text,
                ),
                Text(
                  Helper.toIDR(topUp.amount).substring(4),
                  style: AppStyle.regular2Text,
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kode Unik",
                  style: AppStyle.regular2Text,
                ),
                Text(
                  Helper.toIDR(topUp.uniqueCode).substring(4),
                  style: AppStyle.regular2Text,
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jumlah yang harus di transfer",
                  style: AppStyle.regular2Text,
                ),
                Text(
                  Helper.toIDR(topUp.totalAmount).substring(4),
                  style: AppStyle.title1Text.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                splashColor: AppColor.green.withOpacity(0.2),
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    "Lihat Cara Transfer",
                    style: AppStyle.smallText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.green,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Divider(height: 3, color: Colors.grey),
            SizedBox(height: 16),
            Center(
              child: Text(
                "Anda sudah melakukan transfer?",
                style: AppStyle.regular2Text,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text("Konfirmasi Transfer"),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
