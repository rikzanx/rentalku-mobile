import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';

ValueNotifier<File?> _image = ValueNotifier(null);

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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 60, 16, 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama",
                              style: AppStyle.regular2Text,
                            ),
                            Text(
                              "Alamat",
                              style: AppStyle.regular2Text,
                            ),
                            Text(
                              "TTL",
                              style: AppStyle.regular2Text,
                            ),
                            Text(
                              "No. Telp",
                              style: AppStyle.regular2Text,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ": Muhammad",
                              style: AppStyle.regular2Text,
                            ),
                            Text(
                              ": Jl. Golf 6, Gunungsari, Surabaya",
                              style: AppStyle.regular2Text,
                            ),
                            Text(
                              ": 12 September 2000",
                              style: AppStyle.regular2Text,
                            ),
                            Text(
                              ": 082335812487",
                              style: AppStyle.regular2Text,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
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
                                "https://dummyimage.com/200x200/000/fff&text=foto+profil"),
                            radius: MediaQuery.of(context).size.width * 0.125,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(value),
                            radius: MediaQuery.of(context).size.width * 0.125,
                          ),
                  ),
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

  void getImage(ImageSource media) async {
    XFile? img = await ImagePicker().pickImage(source: media);
    if (img != null) {
      _image.value = File(img.path);
    }
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
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
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
                  getImage(ImageSource.camera);
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
