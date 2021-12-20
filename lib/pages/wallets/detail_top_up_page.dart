import 'dart:io';

import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/strings.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/payment_method.dart';
import 'package:rentalku/models/top_up.dart';
import 'package:rentalku/providers/top_up_provider.dart';

ValueNotifier<File?> _image = ValueNotifier(null);

class DetailTopUpPage extends StatelessWidget {
  final TopUp topUp;
  const DetailTopUpPage({Key? key, required this.topUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => TopUpProvider(),
      builder: (context,_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Detail Top Up"),
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
        body: Consumer<TopUpProvider>(
          builder:(context,state,_){
            return ListView(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
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
                Image.network(
                  assetURL + topUp.paymentMethod.imageURL,
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
                        text: Helper.toIDR(topUp.amount).substring(0, Helper.toIDR(topUp.amount).length - 3),
                        style: AppStyle.display1Text,
                      ),
                      TextSpan(
                        text: Helper.toIDR(topUp.amount).substring(Helper.toIDR(topUp.amount).length - 3),
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
                  Helper.toIDR(topUp.amount-topUp.uniqueCode).substring(4),
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
                  Helper.toIDR(topUp.amount).substring(4),
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
            InkWell(
              borderRadius: BorderRadius.circular(5),
              splashColor: AppColor.green.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  "Lihat Cara Transfer",
                  textAlign: TextAlign.center,
                  style: AppStyle.smallText.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.green,
                  ),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  builder: (context) => ModalSheetBar(),
                );
              },
            ),
            SizedBox(height: 16),
            Divider(height: 3, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Anda sudah melakukan transfer?",
              style: AppStyle.regular2Text,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ValueListenableBuilder<File?>(
              valueListenable: _image,
              builder: (context, image, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Text("Konfirmasi Transfer"),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Konfirmasi Transfer",
                                  style: AppStyle.regular1Text.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                content: Text(
                                  "Lakukan konfirmasi transfer hanya jika Anda telah selesai melakukan transfer sesuai intruksi sebelumnya",
                                  style: AppStyle.smallText,
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      "Belum",
                                      style: AppStyle.regular1Text.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Sudah",
                                      style: AppStyle.regular1Text.copyWith(
                                        color: Colors.green[900],
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                          context, Routes.withdrawComplete);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
                  );
              },
            ),
            SizedBox(height: 16),
          ],
        );
          }
        ),
      ),
      );
  }

  void getImage(ImageSource media) async {
    XFile? img = await ImagePicker().pickImage(source: media);
    if (img != null) {
      _image.value = File(img.path);
    }
  }

  void myAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Silahkan pilih media"),
        content: Container(
          height: MediaQuery.of(context).size.height / 6,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 5),
                    Text("Galeri"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(width: 5),
                    Text("Kamera"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ModalSheetBar() {
    Map<String, List<String>> tutorials = {
      "ATM BCA": [
        "Masukkan Kartu ATM dan PIN BCA Anda",
        "Masuk e menu “Transfer” dan pilih \"ke rekening BCA\"",
        "Masukkan nomor rekening BCA milik RentalKu",
        "Pastikan nama Anda dan jumlah bembayaran sudah benar",
        "Pembayaran selesai. Simpan struk sebagai bukti pembayaran",
      ],
      "KLIK BCA": [],
      "m-BCA (BCA MOBILE)": [],
      "m-BCA (STK - SIM Tool Kit)": [],
    };
    Map<String, ValueNotifier<bool>> collapsed = Map.fromIterables(
      tutorials.keys,
      List.generate(tutorials.length, (index) => ValueNotifier(index != 0)),
    );

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          "Cara Transfer",
          style: AppStyle.title1Text,
          textAlign: TextAlign.center,
        ),
        Text(
          "Mohon perhatikan setiap langkah transfer dibawah ini",
          style: AppStyle.smallText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        for (var tutorial in tutorials.entries)
          Column(
            children: [
              InkWell(
                onTap: () {
                  collapsed[tutorial.key]!.value =
                      !collapsed[tutorial.key]!.value;
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grey),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tutorial.key,
                        style: AppStyle.regular1Text.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: collapsed[tutorial.key]!,
                        builder: (context, value, _) => Icon(
                          value ? Icons.expand_more : Icons.expand_less,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: collapsed[tutorial.key]!,
                builder: (context, value, child) => Collapsible(
                  axis: CollapsibleAxis.vertical,
                  collapsed: collapsed[tutorial.key]!.value,
                  child: child!,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      tutorial.value.length,
                      (index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 16,
                            child: Text(
                              "${index + 1}. ",
                              style: AppStyle.smallText,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${tutorial.value[index]}",
                              style: AppStyle.smallText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
