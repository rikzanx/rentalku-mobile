import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        child: Column(
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
                              debugPrint(file.path);
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<AppProvider>(context, listen: false).userType = UserType.Owner;
                              Navigator.pop(context);
                              // TODO: Remove this
                              if (_formKey.currentState!.validate()) {
                                // process here
                              }
                            },
                            child: Text("Daftar & Jadi Pemilik Mobil"),
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
      ),
    );
  }
}
