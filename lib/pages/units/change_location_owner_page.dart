import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/form_unit_provider.dart';
import 'package:rentalku/services/unit_services.dart';
import 'package:rentalku/widgets/filter_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
  locale: 'id',
  decimalDigits: 0,
  symbol: "Rp. ",
);
String name = "";
String harga = "";
String kategoriId = "";
String kota = "Surabaya";
String seat = "";
String nopol = "";
String tahun ="";
String transmisi = "";
String mesin = "";
String warna = "";
String filePath ="";


class ChangeLocationOwnerPage extends StatelessWidget {
  const ChangeLocationOwnerPage({Key? key}) : super(key: key);

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
          title: Text("Ubah Lokasi garasi"),
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
        body: Consumer<FormUnitProvider>(
          builder: (context,app,_) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    children: [
                      Text(
                        "Pilih Lokasi",
                        style: AppStyle.title3Text,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          "Kota",
                          style: AppStyle.labelText,
                        ),
                      ),
                      Consumer<AppProvider>(
                        builder: (context,state,_) {
                          if(state.homeState == HomeState.Loading){
                            return Center(child: CircularProgressIndicator(color: AppColor.green,),);
                          }else if(state.homeState == HomeState.Error){
                            return Center(child: Text(defaultErrorText),);
                          }
                          return GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 3,
                              crossAxisCount: 3,
                            ),
                            itemCount: state.pilihanKota.length,
                            itemBuilder: (context, index) => FilterShadowWidget(
                                label: state.pilihanKota[index],
                                selected: state.pilihanKota[index] == state.kota,
                                onTap: (status) {
                                  state.kota = state.pilihanKota[index];
                                  kota = state.pilihanKota[index];
                                },
                              ),
                            );
                        }
                      ),
                      SizedBox(height: 16),
                      Consumer<AppProvider>(
                        builder: (context,state,_) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async{
                                if (_formKey.currentState!.validate()) {

                                  if(kota != ""){
                                    showLoaderDialog(context);
                                    Provider.of<AppProvider>(context, listen: false)
                                    .changeLocation(kota)
                                    .then((status) {
                                      if(status){
                                        state.auth();
                                        state.notifyListeners();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: "Sukses Ganti Lokasi.");
                                      }else{
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: "Gagal ganti Lokasi.");
                                      }
                                    }).catchError((msg) {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: defaultErrorText);
                                    });
                                  }else{
                                    alertKolom(context);
                                  }
                                }
                              },
                              child: Text("Ganti Lokasi"),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      );
  }

  void alertKolom(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Peringatan"),
        content: Container(
          height: MediaQuery.of(context).size.height / 9,
          child: Column(
            children:[
              Text(
                "Kolom isian belum lengkap.",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Isi semua kolom!",
                style: TextStyle(color: Colors.red),
              ),
            ],
          )
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Proses..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  
}
