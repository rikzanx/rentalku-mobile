

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/search_units_provider.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';

class DashboardProfilPage extends StatelessWidget {
  const DashboardProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppBar(
          title: Text(
            "Profil",
            style: AppStyle.title1Text.copyWith(
              color: AppColor.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              splashRadius: 24,
              icon: Image.asset('assets/images/chat_icon.png', height: 24),
              onPressed: () {
                Navigator.pushNamed(context, Routes.chats);
              },
            )
          ],
        ),
        SizedBox(height: 24),
        Row(
          children: [
            SizedBox(width: 16),
            Consumer<AppProvider>(
              builder:(context,app,_){
                return CircleAvatar(
                          backgroundImage:NetworkImage(assetURL+app.user!.imageURL),
                          radius: 24,
                        );
              },
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo,",
                    style: AppStyle.regular1Text,
                  ),
                  Consumer<AppProvider>(
                    builder: (context,app,_){
                      return Text(
                            app.user!.name,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: AppStyle.regular1Text.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Consumer<AppProvider>(
              builder: (context, state, _) {
                if (state.isUser){
                  return Container(
                    child: InkWell(
                      child: Text(
                        "Jadi Pemilik Mobil  >",
                        style: AppStyle.smallText.copyWith(
                          color: AppColor.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () async{
                        if(state.user!.userType == UserType.Owner){
                          state.changetoOwner();
                          state.notifyListeners();
                        }else{
                          Navigator.pushNamed(context, Routes.upgradeToOwner);
                        }
                      },
                    ),
                  );
                }else if (state.isOwner){
                  return InkWell(
                    child: Text(
                      "Kembali ke Halaman Penyewa",
                      style: AppStyle.smallText.copyWith(
                        color: AppColor.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async{
                        state.changetoUser();
                        state.notifyListeners();
                    },
                  );
                }
                else{
                  return SizedBox();
                }
              },
            ),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.green,
              ),
              child: Consumer<AppProvider>(
                builder: (context, state, _) => Text(
                  state.isUser
                      ? "Saya Penyewa"
                      : state.isOwner
                          ? "Saya Pemilik Mobil"
                          : "Saya Sopir",
                  style: AppStyle.smallText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          child: new ListTile(
            leading: Icon(Icons.person_outline),
            horizontalTitleGap: 0,
            visualDensity: VisualDensity.compact,
            title: Text(
              'Data Diri',
              style: AppStyle.regular1Text
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.myProfile);
            },
          ),
          decoration:
            new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(color: Colors.grey)
                )
            )
        ),
        Container(
          child: new ListTile(
            leading: Icon(Icons.lock_outline),
            visualDensity: VisualDensity.compact,
            horizontalTitleGap: 0,
            title: Text(
              'Ganti Kata sandi',
              style: AppStyle.regular1Text,
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.updatePassword);
            },
          ),
          decoration:
            new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(color: Colors.grey)
                )
            )
        ),
        Consumer<AppProvider>(
          builder: (context, state, _) => state.isUser ?
            Container(
            child: new Consumer<AppProvider>(
              builder: (context, state, _) => state.isUser
                  ? Consumer<SearchUnitsProvider>(
                    builder:(context,state,_){
                      return ListTile(
                        leading: Icon(Icons.directions_car_outlined),
                        visualDensity: VisualDensity.compact,
                        horizontalTitleGap: 0,
                        title: Text(
                          'Rental Mobil',
                          style: AppStyle.regular1Text,
                        ),
                        onTap: () {
                          state.query = "";
                          state.carType = [];
                          state.search();
                          state.notifyListeners();
                          Navigator.pushNamed(context, Routes.searchUnits);
                        },
                      );
                    }
                    )
                  : SizedBox(),
            ),
            decoration:
              new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: Colors.grey)
                  )
              )
          ) : SizedBox(),
        ),
        
        Consumer<AppProvider>(
          builder: (context,state,_) {
            if(state.isOwner || state.isUser){
              return Container(
                child: new ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined),
                  visualDensity: VisualDensity.compact,
                  horizontalTitleGap: 0,
                  title: Text(
                    'Dompetku',
                    style: AppStyle.regular1Text,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.wallet);
                  },
                ),
                decoration:
                  new BoxDecoration(
                      border: new Border(
                          bottom: new BorderSide(color: Colors.grey)
                      )
                  )
              );
            }else{
              return SizedBox();
            }
          }
        ),
        
        Consumer<AppProvider>(
          builder: (context, state, _) => state.isOwner ?
          Container(
            child: new Consumer<UlasanUnitProvider>(
              builder: (context, ulasan, _) => state.isOwner
                  ? ListTile(
                      leading: Icon(Icons.rate_review_outlined),
                      visualDensity: VisualDensity.compact,
                      horizontalTitleGap: 0,
                      title: Text(
                        'Penilaian dan Ulasan',
                        style: AppStyle.regular1Text,
                      ),
                      onTap: () {
                        ulasan.getUlasanPemilikByUserId().then(
                          (value){
                            ulasan.notifyListeners();
                            Navigator.pushNamed(context, Routes.reviewOwner);
                          }
                        );
                        // Navigator.pushNamed(context, Routes.reviewOwner);
                      },
                    )
                  : SizedBox(),
            ),
            decoration:
              new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: Colors.grey)
                  )
              )
          ) : SizedBox(),
        ),
        Consumer<AppProvider>(
          builder: (context, state, _) => state.isOwner ?
          Container(
            child: new Consumer<AppProvider>(
              builder: (context, state, _) => state.isOwner
                  ? ListTile(
                      leading: Icon(Icons.person_pin_outlined),
                      visualDensity: VisualDensity.compact,
                      horizontalTitleGap: 0,
                      title: Text(
                        'SopirKu',
                        style: AppStyle.regular1Text,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.driverList);
                      },
                    )
                  : SizedBox(width: 0,height: 0,),
            ),
            decoration:
              new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: Colors.grey)
                  )
              )
          ) : SizedBox(),
        ),
        
        Container(
          child: new ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            horizontalTitleGap: 0,
            visualDensity: VisualDensity.compact,
            title: Text(
              'Keluar',
              style: AppStyle.regular1Text.copyWith(
                color: Colors.redAccent,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Yakin untuk logout?",
                      style: AppStyle.regular1Text.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "Tidak",
                          style: AppStyle.regular1Text.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Ya",
                          style: AppStyle.regular1Text.copyWith(
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<AppProvider>(context, listen: false)
                              .logout()
                              .then((_) {
                            Navigator.popUntil(context, (route) => route.isFirst);
                            Navigator.pushReplacementNamed(context, Routes.home);
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          decoration:
            new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(color: Colors.grey)
                )
            )
        ),
        
        
        
        

      ],
    );
  }
}
