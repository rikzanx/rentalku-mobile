import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/providers/password_provider.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:rentalku/network_utils/api.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = "";
    String email = "";
    String password = "";
    String password2 = "";
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
                          onChanged: (value) => name = value,
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
                          onChanged: (value) => email = value,
                        ),
                        SizedBox(height: 16),
                        Consumer<PasswordProvider>(
                          builder: (context,state,_) {
                            return TextFieldWithShadow(
                              labelText: "Ketik kata sandi anda",
                              hintText: "kata sandi",
                              obscureText: state.obsecureText,
                              withShowPassword: true,
                              onPressed: (){
                                state.obsecureText=!state.obsecureText;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kolom kata sandi wajib diisi';
                                } else if (value.length < 6) {
                                  return 'Panjang kata sandi minimal 6 karakter';
                                }
                                return null;
                              },
                              onChanged: (value) => password = value,
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        Consumer<PasswordProvider>(
                          builder: (context,state,_) {
                            return TextFieldWithShadow(
                              labelText: "Ketik ulang kata sandi anda",
                              hintText: "kata sandi",
                              obscureText: state.obsecureText2,
                              withShowPassword: true,
                              onPressed: (){
                                state.obsecureText2 = !state.obsecureText2;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kolom kata sandi wajib diisi';
                                } else if (value.length < 6) {
                                  return 'Panjang kata sandi minimal 6 karakter';
                                } else if (password != value){
                                  return 'kata sandi Tidak sama';
                                }
                                return null;
                              },
                              onChanged: (value) => password2 = value,
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Remove this
                            if (_formKey.currentState!.validate()) {
                              // process here
                              showLoaderDialog(context);
                              Provider.of<AppProvider>(context, listen: false)
                                  .daftar(name,email, password)
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
