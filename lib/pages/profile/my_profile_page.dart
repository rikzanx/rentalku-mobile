import 'dart:io';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/services/api_response.dart';

ValueNotifier<File?> _image = ValueNotifier(null);
ValueNotifier<String?> _imageLink = ValueNotifier(null);
String _imageFilePath = '';
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

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
        title: Text("Data Diri"),
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 24),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.125,
                ),
                child: Material(
                  elevation: 3,
                  color: AppColor.lightGreen,
                  borderRadius: BorderRadius.circular(10),
                  child: Consumer<AppProvider>(
                    builder:(context,app,_){
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 60, 16, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child:Text(
                                      "Nama",
                                      style: AppStyle.regular2Text,
                                    ),
                                ),
                                Text(
                                  ":",
                                  style: AppStyle.regular2Text,
                                ),
                                Expanded(
                                  child: Text(
                                      app.user!.name.toString(),
                                      style: AppStyle.regular2Text,
                                    ),
                                ),  
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child:Text(
                                      "Alamat",
                                      style: AppStyle.regular2Text,
                                    ),
                                ),
                                Text(
                                  ":",
                                  style: AppStyle.regular2Text,
                                ),
                                Expanded(
                                  child: Text(
                                      app.user!.address.toString(),
                                      style: AppStyle.regular2Text,
                                    ),
                                ),  
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child:Text(
                                      "TTL",
                                      style: AppStyle.regular2Text,
                                    ),
                                ),
                                Text(
                                  ":",
                                  style: AppStyle.regular2Text,
                                ),
                                Expanded(
                                  child: Text(
                                      app.user!.tanggalLahir,
                                      style: AppStyle.regular2Text,
                                    ),
                                ),  
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child:Text(
                                      "No. Telp",
                                      style: AppStyle.regular2Text,
                                    ),
                                ),
                                Text(
                                  ":",
                                  style: AppStyle.regular2Text,
                                ),
                                Expanded(
                                  child: Text(
                                      app.user!.phone.toString(),
                                      style: AppStyle.regular2Text,
                                    ),
                                ),  
                              ],
                            ),
                          ),
                        ],
                  );
                    },
                  ),
                  
                ),
              ),
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
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.editProfile);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit,
                      size: 16,
                      color: AppColor.green,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Edit",
                      style: AppStyle.regular1Text.copyWith(
                        color: AppColor.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource media, BuildContext context) async {
    
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
                  // getImage(ImageSource.gallery,context);
                  changeImage(ImageSource.gallery,context).then(
                    (value){
                      if(value){
                        Navigator.pop(context);
                      }else{
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
                  Navigator.pop(context);
                  getImage(ImageSource.camera,context);
                  
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
}
