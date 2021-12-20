import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/form_unit_provider.dart';
import 'package:rentalku/providers/order_provider.dart';
import 'package:rentalku/providers/search_units_provider.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';
import 'package:rentalku/widgets/star_rating_widget.dart';

class DetailUnitPage extends StatelessWidget {
  final Unit unit;
  const DetailUnitPage({Key? key,required this.unit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OrderProvider>(context,listen: false).getUnitDetail(unit.id);
    return ChangeNotifierProvider(
      create: (context)=> SearchUnitsProvider(),
      builder: (context,_) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Detail Produk"),
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
      body: Consumer<OrderProvider>(
        builder: (context,detail,_) {
          if(detail.homeState == HomeState.Loading){
            return Center(child: CircularProgressIndicator(color: AppColor.green,),);
          }
          if(detail.homeState == HomeState.Error){
            return Center(child:Text(defaultErrorText));
          }
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Container(
                child:Consumer<SearchUnitsProvider>(
                  builder:(context,state,_){
                    if(state.homeState == HomeState.Loading){
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.green,
                        ),
                      );
                    }
                    if(state.homeState == HomeState.Error){
                      return Center(
                        child: Text(
                          defaultErrorText
                        ),
                      );
                    }
                    return Material(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.hardEdge,
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network(
                              assetURL+unit.imageURL,
                              height: MediaQuery.of(context).size.width * 0.25,
                            ),
                            SizedBox(height: 16),
                            Text(
                              unit.name.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: AppStyle.regular1Text.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              unit.kategoriName.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.regular1Text,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              Helper.toIDR(unit.price) + "/Hari",
                              style: AppStyle.smallText.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.yellow,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  "Review",
                                  style: AppStyle.regular2Text.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${unit.rating.toString()}/5",
                                  style: AppStyle.regular2Text,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                StarRating(rating: unit.rating, size: 20),
                                SizedBox(width: 10),
                                Consumer<UlasanUnitProvider>(
                                  builder: (context,app,_){
                                    return InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                        child: Text(
                                          "Lihat semua ulasan",
                                          style: AppStyle.smallText.copyWith(
                                            color: AppColor.green,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        app.kendaraanId = unit.id;
                                        app.ulasanUnit = null;
                                        app.getUlasan(unit.id);
                                        app.notifyListeners();
                                        Navigator.pushNamed(context, Routes.reviewProduct);
                                      },
                                    );
                                  }),
                              ],
                            ),
                            SizedBox(height: 16),
                            Consumer<UlasanUnitProvider>(
                              builder:(context,app,_){
                                return InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Lihat Penilaian Pemilik Mobil",
                                    style: AppStyle.regular1Text.copyWith(
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Ink(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.green.withOpacity(0.5),
                                    ),
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 20,
                                      color: AppColor.green,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                app.kendaraanId = unit.id;
                                app.getUlasanPemilik(unit.id).then(
                                  (value){

                                    app.notifyListeners();
                                Navigator.pushNamed(context, Routes.reviewOwner);
                                  }
                                  );
                              },
                            );
                              },
                            ),
                            
                            SizedBox(height: 16),
                            Divider(thickness: 2, color: Colors.grey[500]),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        color: AppColor.green,
                                      ),
                                      Text(
                                        "${unit.capacity.toString()} Penumpang",
                                        style: AppStyle.smallText.copyWith(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.directions_car,
                                        color: AppColor.green,
                                      ),
                                      Text(
                                        "Tahun ${unit.tahun.toString()}",
                                        style: AppStyle.smallText.copyWith(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(thickness: 2, color: Colors.grey[500]),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.directions_car,
                                    size: 20, color: AppColor.green),
                                SizedBox(width: 5),
                                Text(
                                  "Transmisi",
                                  style: AppStyle.regular2Text,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.directions_car,
                                    size: 20, color: AppColor.green),
                                SizedBox(width: 5),
                                Text(
                                  "Mesin ${unit.mesin}",
                                  style: AppStyle.regular2Text,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.directions_car,
                                    size: 20, color: AppColor.green),
                                SizedBox(width: 5),
                                Text(
                                  "${unit.capacity.toString()} Penumpang",
                                  style: AppStyle.regular2Text,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.directions_car,
                                    size: 20, color: AppColor.green),
                                SizedBox(width: 5),
                                Text(
                                  "Warna ${unit.warna}",
                                  style: AppStyle.regular2Text,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.directions_car,
                                    size: 20, color: AppColor.green),
                                SizedBox(width: 5),
                                Text(
                                  "Tahun ${unit.tahun.toString()}",
                                  style: AppStyle.regular2Text,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.directions_car,
                                    size: 20, color: AppColor.green),
                                SizedBox(width: 5),
                                Text(
                                  "Lokasi ${detail.unitDetail!.pemilik.city}",
                                  style: AppStyle.regular2Text,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Consumer<AppProvider>(
                builder: (context, state, _) {
                  if (state.isUser)
                    return Consumer<OrderProvider>(
                      builder: (context,app,_){
                        return ElevatedButton(
                          child: Text("Lanjut ke Pemesanan"),
                          onPressed: () {
                            app.getUnitDetail(unit.id);
                            app.notifyListeners();
                            Navigator.pushNamed(context, Routes.orderUnit);
                          },
                        );
                      },
                    );
                  else if (state.isOwner) {
                    return Consumer<FormUnitProvider>(
                      builder: (context,state,_) {
                        return Row(
                          children: [
                            TextButton(
                              onPressed: () async{
                                state.kategoriSelected = unit.kategori.id;
                                state.getKategoriList();
                                print(state.kategoriSelected);
                                state.notifyListeners();
                                Navigator.pushNamed(
                                  context, Routes.editUnit,
                                  arguments: unit);
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
                                    "Ubah",
                                    style: AppStyle.regular1Text.copyWith(
                                      color: AppColor.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    );
                  } else
                    return SizedBox();
                },
              ),
            ],
          );
        }
      ),
    ),
    );
  }
}
