import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/pages/profile/upgrade_owner_car_page.dart';
import 'package:rentalku/providers/password_provider.dart';
import 'package:rentalku/providers/sopir_provider.dart';
import 'package:rentalku/services/sopir_services.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
String nama = "";
String email ="";
String password = "";
String foto_ktp ="";
String foto_sim = "";
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
      body:Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
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
                      onChanged: (value){
                        nama = value;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFieldWithShadow(
                      labelText: "Ketik email",
                      hintText: "email@gmail.com",
                      labelColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom email wajib diisi';
                        }
                        return null;
                      },
                      onChanged: (value){
                        email = value;
                      },
                    ),
                    SizedBox(height: 16),
                    Consumer<PasswordProvider>(
                      builder: (context,state,_) {
                        return TextFieldWithShadow(
                          labelText: "Ketik kata sandi",
                          hintText: "kata sandi",
                          labelColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          obscureText: state.obsecureText,
                          withShowPassword: true,
                          onPressed: (){
                            state.obsecureText = !state.obsecureText;
                            state.notifyListeners();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom kata sandi wajib diisi';
                            } else if (value.length < 6) {
                              return 'Panjang kata sandi minimal 6 karakter';
                            }
                            return null;
                          },
                          onChanged: (value){
                            password = value;
                          },
                        );
                      }
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
                        foto_ktp= file.path;
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
                        foto_sim = file.path;
                      },
                    ),
                    SizedBox(height: 16),
                    Consumer<SopirProvider>(
                      builder: (context,state,_) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // process here
                                print(nama); print(email); print(password); print(foto_ktp); print(foto_sim);
                                if(nama != "" && email != "" && password != "" && foto_ktp != "" && foto_sim != ""){
                                  showLoaderDialog(context);
                                  state.registerDriver(nama, email, password, foto_ktp, foto_sim)
                                  .then((status){
                                    if(status){
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                      context, Routes.addDriverComplete);
                                      Fluttertoast.showToast(msg: "Sukses menambahkan sopir..");
                                    }else{
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: "Gagal menambahkan sopir.");
                                    }

                                  }).catchError((msg){
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(msg: defaultErrorText);
                                  });
                                }else{
                                  alertKolom(context);
                                }
                              }
                            },
                            child: Text("Tambahkan"),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
        
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
