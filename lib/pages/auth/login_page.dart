import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.arrow_back),
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
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Silahkan Masuk",
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
                          Text(
                            "Masukkan email anda",
                            style: AppStyle.labelText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(20),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "muhammad@gmail.com",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: AppStyle.regularText,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kolom email wajib diisi';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Masukkan password anda",
                            style: AppStyle.labelText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(20),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "password",
                              ),
                              style: AppStyle.regularText,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kolom password wajib diisi';
                                } else if (value.length < 6) {
                                  return 'Panjang password minimal 6 karakter';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Remove this
                                Navigator.pushReplacementNamed(
                                    context, Routes.dashboard);

                                if (_formKey.currentState!.validate()) {
                                  // process here
                                }
                              },
                              child: Text("Masuk"),
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
                style: AppStyle.regularText,
                children: [
                  TextSpan(
                    text: "Belum punya akun? ",
                    style: AppStyle.regularText.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Daftar",
                    style: AppStyle.regularText.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: AppColor.yellow,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(context, Routes.register);
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
