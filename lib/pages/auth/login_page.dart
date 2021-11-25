import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email = "";
    String password = "";

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
                    "Silahkan Masuk",
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
                          onChanged: (value) => email = value,
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
                          onChanged: (value) => password = value,
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .login(email, password)
                                  .then((_) {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                                Navigator.pushReplacementNamed(
                                    context, Routes.dashboard);
                              }).catchError((msg) {
                                Fluttertoast.showToast(msg: msg.toString());
                              });
                            }
                          },
                          child: Text("Masuk"),
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
    );
  }
}
