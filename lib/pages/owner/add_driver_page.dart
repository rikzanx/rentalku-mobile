import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();

class AddDriverPage extends StatelessWidget {
  const AddDriverPage({Key? key}) : super(key: key);

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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            Text(
              "Isi Data Diri Sopir",
              style: AppStyle.title3Text,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextFieldWithShadow(
              labelText: "Ketik nama lengkap",
              hintText: "Nama Lengkap",
              labelColor: Colors.black,
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
              labelText: "Ketik username",
              hintText: "username",
              labelColor: Colors.black,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kolom username wajib diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFieldWithShadow(
              labelText: "Ketik password",
              hintText: "password",
              labelColor: Colors.black,
              textInputAction: TextInputAction.next,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kolom password wajib diisi';
                } else if (value.length < 6) {
                  return 'Panjang password minimal 6 karakter';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFieldUploadWithShadow(
              labelText: "Upload Foto KTP",
              hintText: "Upload",
              labelColor: Colors.black,
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
            SizedBox(height: 16),
            TextFieldUploadWithShadow(
              labelText: "Upload Foto SIM A",
              hintText: "Upload",
              labelColor: Colors.black,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Kolom upload SIM A wajib diisi';
                }
                return null;
              },
              onFileChanged: (File file) {
                debugPrint(file.path);
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // process here
                  }
                },
                child: Text("Tambahkan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
