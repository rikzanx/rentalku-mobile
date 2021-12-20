import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
ValueNotifier<File?> _image = ValueNotifier(null);
var tanggal_controller = new TextEditingController();
var formatter = new DateFormat('yyyy-MM-d');
String nama = "";
String alamat = "";
String tanggal = "";
String telp = "";

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);
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
        title: Text("Edit Data Diri"),
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
            child: Consumer<AppProvider>(
              builder:(context,app,_){
                print(app.user);
                nama = (app.user!.name != null)? app.user!.name:'';
                alamat = (app.user!.address != null)? app.user!.address.toString():'';
                tanggal = (app.user!.tanggalLahir != "null")? app.user!.tanggalLahir:'';
                telp =(app.user!.phone != null)? app.user!.phone.toString():'';

                tanggal_controller.text = (app.user!.tanggalLahir != "null")? app.user!.tanggalLahir:'';
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    SizedBox(height:24),
                    Stack(
                      children: [
                        Center(
                          child: Consumer<AppProvider>(
                              builder:(context,app,_){
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.125,
                                    ),
                                    border: Border.all(color: Colors.white, width: 5),
                                  ),
                                  child: ValueListenableBuilder<File?>(
                                    valueListenable: _image,
                                    builder: (context, value, _) => value == null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                assetURL+app.user!.imageURL),
                                            radius: MediaQuery.of(context).size.width * 0.125,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: FileImage(value),
                                            radius: MediaQuery.of(context).size.width * 0.125,
                                          ),
                                  ),
                                );
                              }
                          ),
                          
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.width * 0.125 + 12,
                          left: MediaQuery.of(context).size.width * 0.5,
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.hardEdge,
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppColor.green,
                                ),
                              ),
                              onTap: () {
                                myAlert(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFieldWithShadow(
                        controller: TextEditingController()..text = (app.user!.name != null)? app.user!.name:'',
                        labelText: "Ketik nama lengkap anda",
                        hintText: "Nama Lengkap",
                        labelColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom nama lengkap wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value) => nama = value,
                    ),
                    SizedBox(height: 16),
                    TextFieldWithShadow(
                      controller: TextEditingController()..text = (app.user!.address != null)? app.user!.address.toString():'',
                      labelText: "Ketik alamat anda",
                      hintText: "Alamat",
                      labelColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom alamat wajib diisi';
                        }
                        return null;
                      },
                      onChanged: (value) => alamat = value,
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year - 17),
                          firstDate: DateTime(DateTime.now().year - 100),
                          lastDate: DateTime(DateTime.now().year - 17),
                        ).then((DateTime? value) {
                          tanggal = DateFormat('yyyy-MM-dd').format(value!);
                          tanggal_controller.text = DateFormat('yyyy-MM-dd').format(value);
                          print(DateFormat('yyyy-MM-dd').format(value));
                        });
                      },
                      child: TextFieldWithShadow(
                        controller: tanggal_controller,
                        labelText: "Ketik tanggal lahir anda",
                        hintText: "Tanggal lahir",
                        keyboardType: TextInputType.datetime,
                        labelColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom tanggal lahir wajib diisi';
                          }
                          return null;
                        },
                        enabled: false,
                        onChanged: (value) => tanggal = value,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFieldWithShadow(
                      controller: TextEditingController()..text = (app.user!.phone != null)? app.user!.phone.toString():'',
                      labelText: "Ketik nomor hp anda",
                      hintText: "No. Handphone",
                      keyboardType: TextInputType.phone,
                      labelColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kolom nomor hp wajib diisi';
                        }
                        return null;
                      },
                      onChanged: (value) => telp = value,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showLoaderDialog(context);
                            changeUser(context,nama,alamat,tanggal,telp).then(
                              (value){
                                if(value){
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(msg: "Sukses edit data diri.");
                                }else{
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(msg: "Gagal edit data diri.");
                                }
                              },
                            );
                          }
                        },
                        child: Text("Simpan perubahan"),
                      ),
                    ),
                  ],
                );
              }
            ),
      )
    );
  }

  Future<bool> changeImage(ImageSource media,BuildContext context) async{
    print("iki change");
    XFile? img = await ImagePicker().pickImage(source: media);
    if (img != null) {
      // _image.value = File(img.path);
      bool response = await Provider.of<AppProvider>(context,listen: false).changeImage(img.path.toString());
      return response;
    }
    print("gaonok");
    return false;
    
  }

  Future<bool> changeUser(BuildContext context,String nama, String alamat, String tanggal_lahir, String telp) async{
    bool response = await Provider.of<AppProvider>(context,listen: false).changeUser(nama,alamat,tanggal_lahir,telp);

    return response;
  }

  void myAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Silahkan pilih media"),
        content: Container(
          height: MediaQuery.of(context).size.height / 6,
          child: Column(
            children: [
              TextButton(
                onPressed: () async{
                  // 
                  // CircularProgressIndicator(color: Colors.green);
                  // getImage(ImageSource.gallery,context);
                  showLoaderDialog(context);
                  changeImage(ImageSource.gallery,context).then(
                    (value){
                      if(value){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Sukses merubah foto profil.");
                      }else{
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Gagal merubah foto profil.");
                      }
                    },
                  );
                  // bool updateImage = await Provider.of<AppProvider>(context,listen: false).changeImage(img.path.toString());
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 5),
                    Text("Galeri"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  changeImage(ImageSource.gallery,context).then(
                    (value){
                      if(value){
                        Navigator.pop(context);
                      }else{
                        Fluttertoast.showToast(msg: "Gagal merubah foto profil.");
                      }
                    },
                  );
                  
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(width: 5),
                    Text("Kamera"),
                  ],
                ),
              ),
            ],
          ),
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
