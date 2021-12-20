import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/article.dart';
import 'package:rentalku/models/slider_image.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/dashboard_provider.dart';
import 'package:rentalku/providers/form_unit_provider.dart';
import 'package:rentalku/providers/search_units_provider.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';
import 'package:rentalku/services/homepage_service.dart';
import 'package:rentalku/widgets/article_card_widget.dart';
import 'package:rentalku/widgets/balance_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';


class DashboardHomePage extends StatelessWidget {
  
  const DashboardHomePage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardProvider(),
      builder: (context,_){
        final model = Provider.of<AppProvider>(context,listen: false).getSaldo();
        final model2 = Provider.of<DashboardProvider>(context,listen: false).getSliderImages();
        final model3 = Provider.of<DashboardProvider>(context,listen: false).getMostUnits();
        
        return ListView(
          children: [
            AppBar(
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset("assets/images/rentalku.png", height: 16),
              ),
              backgroundColor: Colors.white,
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
            Consumer<AppProvider>(
              builder: (context, app, _) => app.isUser ? UserInfo(context) : app.isOwner? OwnerInfo(context) : DriverInfo(context),
            ),
            SizedBox(height: 12),
            Container(
              height: 6,
              color: AppColor.grey,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              
            ),
            Consumer<DashboardProvider>(builder:(context,state,_){
              if(state.homeState == HomeState.Loading){
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: CircularProgressIndicator(color: AppColor.green,),
                );
              }
              if(state.homeState == HomeState.Error){
                return Center(child: Text(defaultErrorText),);
              }
              return Column(
                children:List.generate(
                  state.sliderImages.length,
                  (index) => Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: ArticleCardWidget(
                      article: Article(
                        id: 1,
                        title: "Enam Teknik Mencuci Mobil yang Benar, Jangan Asal!",
                        category: "Otomotif",
                        imageURL: assetURL+state.sliderImages[index].imageURL,
                        webURL: "http://id.wikipedia.org/wiki/Rantai_blok",
                      ),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 6),
          ],
        );
      },
    );
  }

  Widget UserInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nama User
              Expanded(
                flex: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo,",
                      style: AppStyle.regular1Text,
                    ),
                    Consumer<AppProvider>(
                      builder: (context, app, _){
                        return Text(
                            app.user!.name.toString(),
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
              // Saldo
              Expanded(
                flex: 55,
                child:
                Consumer<AppProvider>(
                  builder: (context,state,_){
                    if(state.homeState == HomeState.Loading){
                      return Center(
                        child: CircularProgressIndicator(color: AppColor.green),
                      );
                    }
                    if(state.homeState == HomeState.Error){
                      return Center(child: Text(defaultErrorText),);
                    }
                    return BalanceWidget(
                        balance: state.dompet!.saldo,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.topUp);
                        },
                      );
                  },
                ),
                
              ),
            ],
          ),
          SizedBox(height: 12),
          Form(
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  Consumer<SearchUnitsProvider>(
                    builder: (context,state,_){
                      return Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Cari di RentalKu",
                            hintStyle: AppStyle.smallText.copyWith(
                              color: Colors.black,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                          ),
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value){
                            // print(value);
                            state.query = value;
                            state.carType = [];
                            state.notifyListeners();
                            state.search();
                            Navigator.pushNamed(context, Routes.searchUnits);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom username wajib diisi';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                      
                  Padding(
                    padding: EdgeInsets.fromLTRB(4, 4, 8, 4),
                    child: Icon(Icons.search, size: 16),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Consumer<DashboardProvider>(builder:(context,state,_){
              if(state.homeState == HomeState.Loading){
                return Center(child: CircularProgressIndicator(color: AppColor.green,),);
              }
              if(state.homeState == HomeState.Error){
                return Center(child: Text(defaultErrorText),);
              }
              return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: 
                            List.generate(
                            state.mostUnits.length,
                            (index) => Container(
                              padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                              child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              elevation: 2,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: (MediaQuery.of(context).size.width - 56) / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                    child: Column(
                                      children: [
                                        Material(
                                          elevation: 4,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: (MediaQuery.of(context).size.width - 56) / 2.5,
                                            height: (MediaQuery.of(context).size.width - 56) / 5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(assetURL+state.mostUnits[index].imageURL),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(state.mostUnits[index].kategoriName, style: AppStyle.categoryText),
                                                    Text(state.mostUnits[index].name, style: AppStyle.nameProduk),
                                                  ],
                                                ),
                                              ),
                                              Text(Helper.toIDR(state.mostUnits[index].price), style: AppStyle.hargaProduk),
                                            ],),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.star, size: 7, color: AppColor.yellow),
                                              SizedBox(width: 2),
                                              Text(
                                                state.mostUnits[index].rating.toString(),
                                                style: AppStyle.nameProduk,
                                              ),
                                              SizedBox(width: 2),
                                              Icon(Icons.people, size: 12, color: AppColor.green),
                                              SizedBox(width: 2),
                                              Text(
                                                state.mostUnits[index].capacity.toString(),
                                                style: AppStyle.nameProduk,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.detailUnit,
                                      arguments: state.mostUnits[index]
                                    );
                                  },
                                ),
                              ),
                            ),
                            ),
                            ),
                          ),
                      ),
                      Consumer<SearchUnitsProvider>(
                        builder: (context,state,_){
                          return Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Container(
                                    child: InkWell(
                                      child: Padding(
                                              padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    splashRadius: 24,
                                                    icon: Icon(Icons.chevron_right,color: AppColor.green,),
                                                    onPressed: () {
                                                      // Navigator.pop(context);
                                                      state.query = "";
                                                      state.carType = [];
                                                      state.notifyListeners();
                                                      state.search();
                                                      Navigator.pushNamed(context, Routes.searchUnits);
                                                    },
                                                  ),
                                                  Text(
                                                    "Lihat Lainnya",
                                                    style: AppStyle.lainnyaText,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                            );
                        },
                      ),
                       
                    ]
                  );
              
            }),
          
          
        ],
      ),
    );
  }

  Widget OwnerInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nama User
              Expanded(
                flex: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo,",
                      style: AppStyle.regular1Text,
                    ),
                    Consumer<AppProvider>(
                      builder: (context, app, _){
                        return Text(
                            app.user!.name.toString(),
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
              // Saldo
              Expanded(
                flex: 55,
                child: Consumer<AppProvider>(
                  builder: (context,state,_){
                    if(state.homeState == HomeState.Loading){
                      return Center(
                        child: CircularProgressIndicator(color: AppColor.green),
                      );
                    }
                    if(state.homeState == HomeState.Error){
                      return Center(child: Text(defaultErrorText),);
                    }
                    return BalanceWidget(
                        balance: state.dompet!.saldo,
                        actionName: "Tarik",
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.withdraw);
                        },
                      );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Form(
            child: Material(
              color: Colors.white,
              elevation: 1,
              borderRadius: BorderRadius.circular(5),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(4, 4, 8, 4),
                    child: Icon(Icons.location_pin, size: 16),
                  ),
                  Consumer<AppProvider>(
                    builder: (context,state,_) {
                      return Expanded(
                        child: TextFormField(
                          controller: TextEditingController(text: state.user!.city.toString()),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                          ),
                          // enabled: false,
                          onTap: (){
                            state.setKota();
                            Navigator.pushNamed(context, Routes.changeLocation);

                          },
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<FormUnitProvider>(
                builder: (context,state,_) {
                  return Expanded(
                    child: Material(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColor.green),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      elevation: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -6,
                              left: -6,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.green,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.directions_car,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              top: -25,
                              child: Icon(
                                Icons.directions_car,
                                color: AppColor.lightGreen,
                                size: 108,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              alignment: Alignment.center,
                              child: Text(
                                "Galeri Unitku",
                                style: AppStyle.regular2Text,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          state.getMyUnits();
                          Navigator.pushNamed(context, Routes.myUnits);
                        },
                      ),
                    ),
                  );
                }
              ),
              SizedBox(width: 16),
              Consumer<FormUnitProvider>(
                builder: (context,state,_) {
                  return Expanded(
                    child: Material(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColor.green),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      elevation: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -6,
                              left: -6,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.green,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              top: -25,
                              child: Icon(
                                Icons.add_circle_outline,
                                color: AppColor.lightGreen,
                                size: 108,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              alignment: Alignment.center,
                              child: Text(
                                "Tambah Unit Rental",
                                style: AppStyle.regular2Text,
                              ),
                            ),
                          ],
                        ),
                        onTap: () async{
                          state.getKategoriList();
                          state.notifyListeners();
                          Navigator.pushNamed(context, Routes.addUnit);
                        },
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget DriverInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nama User
              Expanded(
                flex: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo,",
                      style: AppStyle.regular1Text,
                    ),
                    Consumer<AppProvider>(
                      builder: (context, app, _){
                        return Text(
                            app.user!.name.toString(),
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
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.green,
            ),
            child: Text(
              "Saya Sopir",
              style: AppStyle.smallText.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 12),
          Consumer<UlasanUnitProvider>(
            builder: (context,state,_) {
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                child: Ink(
                  padding: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://unsplash.com/photos/H7yW_lVGJuI/download?force=true&w=640"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        AppColor.green.withOpacity(0.5),
                        BlendMode.srcOver,
                      ),
                    ),
                  ),
                  child: Text(
                    "Penilaian dan Ulasan",
                    style: AppStyle.regular2Text.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () {
                  state.getUlasanPemilikByUserId();
                  state.notifyListeners();
                  Navigator.pushNamed(context, Routes.reviewDriver);
                },
              );
            }
          )
        ],
      ),
    );
  }
}
