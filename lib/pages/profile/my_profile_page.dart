import 'package:flutter/material.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/styles.dart';

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
        titleTextStyle: AppStyle.title2Text.copyWith(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      16, MediaQuery.of(context).size.width * 0.125, 16, 0),
                  child: Material(
                    elevation: 3,
                    color: Color(0xFFBFDED9),
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
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.125),
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://lorempixel.com/200/200/people/"),
                      radius: MediaQuery.of(context).size.width * 0.125,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextButton(
                onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
