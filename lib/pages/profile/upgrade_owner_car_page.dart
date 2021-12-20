import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
String name = "";
String nik = "";
String filePath = "";

class UpgradeOwnerCarPage extends StatelessWidget {
  const UpgradeOwnerCarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          "Kembali",
          style: AppStyle.title1Text.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          Material(
            color: AppColor.green,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Lengkapi Data Diri Anda",
                    style: AppStyle.heading1Text.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Untuk menjadi pemilik mobil",
                    style: AppStyle.regular2Text.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFieldWithShadow(
                          labelText: "Ketik nama lengkap anda",
                          hintText: "Nama Lengkap",
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom nama lengkap wajib diisi';
                            }
                            return null;
                          },
                          onChanged: (value){
                            name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFieldWithShadow(
                          labelText: "Nomor Induk Kependudukan",
                          hintText: "16 Digit NIK",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom NIK wajib diisi';
                            }
                            return null;
                          },
                          onChanged: (value){
                            nik = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFieldUploadWithShadow(
                          labelText: "Upload Foto KTP",
                          hintText: "Upload",
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom upload KTP wajib diisi';
                            }
                            return null;
                          },
                          onFileChanged: (File file) {
                            filePath = file.path;
                          },
                        ),
                        Consumer<AppProvider>(
                          builder: (context,state,_) {
                            return ElevatedButton(
                              onPressed: () async{
                                // TODO: Remove this
                                if (_formKey.currentState!.validate()) {
                                  if(name != "" && nik != "" && filePath != ""){
                                    showLoaderDialog(context);
                                    Provider.of<AppProvider>(context, listen: false)
                                    .registerOwner(name, nik, filePath)
                                    .then((status) {
                                      if(status){
                                        state.changetoOwner();
                                        state.notifyListeners();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: "Sukses terdaftar sebagai pemilik.");
                                      }else{
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: "Gagal terdaftar sebagai pemilik.");
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
                              child: Text("Daftar & Jadi Pemilik Mobil"),
                            );
                          }
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
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
