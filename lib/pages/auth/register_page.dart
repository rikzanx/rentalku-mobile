import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
        title: Text("Kembali"),
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
                      "Daftar Pengguna Baru",
                      style: AppStyle.heading1Text.copyWith(
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
                            labelText: "Ketik email anda",
                            hintText: "alamatemail@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Kolom email wajib diisi';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFieldWithShadow(
                            labelText: "Ketik password anda",
                            hintText: "password",
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
                          TextFieldWithShadow(
                            labelText: "Ketik ulang password anda",
                            hintText: "password",
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
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Remove this
                              if (_formKey.currentState!.validate()) {
                                // process here
                              }
                            },
                            child: Text("Daftar"),
                          ),
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
