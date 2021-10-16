import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/routes.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Daftar Pengguna Baru",
                      style: AppStyle.heading1Text.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldWithShadow(
                            labelText: "Masukkan nama lengkap anda",
                            hintText: "Muhammad Andri",
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
                            labelText: "Masukkan email anda",
                            hintText: "muhammad@gmail.com",
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
                            labelText: "Masukkan password anda",
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
                            labelText: "Masukkan ulang password anda",
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Remove this
                                if (_formKey.currentState!.validate()) {
                                  // process here
                                }
                              },
                              child: Text("Daftar"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: AppStyle.regular1Text,
                children: [
                  TextSpan(
                    text: "Sudah punya akun? ",
                    style: AppStyle.regular1Text.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Masuk",
                    style: AppStyle.regular1Text.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: AppColor.yellow,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
