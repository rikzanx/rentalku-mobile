import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/providers/app_provider.dart';
import 'package:rentalku/providers/order_provider.dart';
import 'package:rentalku/services/order_services.dart';
import 'package:rentalku/widgets/balance_widget.dart';
import 'package:rentalku/widgets/driver_card_widget.dart';
import 'package:rentalku/widgets/supir_button_widget.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();
String nama = "";
String telp = "";
String nik = "";
String filePath = "";

class OrderUnitPage extends StatelessWidget {
  const OrderUnitPage({Key? key}) : super(key: key);

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
          title: Text("Pemesanan"),
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
          builder:(context,state,_){
            if(state.homeState == HomeState.Loading){
              return Center(child: CircularProgressIndicator(color: AppColor.green,),);
            }
            if(state.homeState == HomeState.Error){
              return Center(child: Text(defaultErrorText),);
            }
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(assetURL+state.unitDetail!.imageURL),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.unitDetail!.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: AppStyle.regular1Text.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      state.unitDetail!.kategoriName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyle.regular1Text.copyWith(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    Consumer<OrderProvider>(
                                      builder: (context, state, _) => Text(
                                        "${state.days} hari",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppStyle.smallText.copyWith(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(5),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "CAR RENT - ${state.unitDetail!.pemilik.name}",
                                    style: AppStyle.smallText.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                      state.unitDetail!.withDriver
                                          ? "Dengan Sopir"
                                          : "Tanpa Sopir",
                                      style: AppStyle.smallText),
                                ],
                              ),
                            ),
                          ),
                          
                          
                          Text("Sopir", style: AppStyle.smallText),
                          SizedBox(height: 10),
                          Consumer<OrderProvider>(
                            builder:(context,state,_){
                              return Row(
                                children: [
                                    SupirButtonWidget(
                                      title: "Tanpa Sopir",
                                      active: (state.withDriver)?false:true,
                                      onPressed: () async{
                                        state.withDriver = false;
                                        state.notifyListeners();
                                      },
                                    ),
                                    SizedBox(width: 10,),
                                    SupirButtonWidget(
                                      title: "Dengan Sopir",
                                      active: (state.withDriver)?true:false,
                                      onPressed: () async{
                                        state.withDriver = true;
                                        state.notifyListeners();
                                      },
                                    ),
                                ],
                              );
                            }
                          ),
                          Text("Alamat", style: AppStyle.smallText),
                          Consumer<OrderProvider>(
                            builder: (context, state, _) => InkWell(
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.green,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Text(
                                  (state.address == null)
                                      ? "Pilih lokasi"
                                      : state.address!,
                                  style: AppStyle.smallText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                final Map<String, dynamic> result =
                                    await Navigator.pushNamed(
                                            context, Routes.pickLocation)
                                        as Map<String, dynamic>;
                                print("oke");
                                print("oke");
                                print("oke");
                                print("oke");
                                print("oke");
                                print("oke");
                                print("oke");
                                print("oke");
                                print("oke");
                                print("oke");
                                print(result['latitude']);
                                state.lat = result['latitude'] as double;
                                state.lng =result['longitude'] as double;
                                state.address = result['name'] as String;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Tanggal", style: AppStyle.smallText),
                          Consumer<OrderProvider>(
                            builder: (context, state, _) => InkWell(
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.green,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Text(
                                  state.startDate == null || state.endDate == null
                                      ? "Pilih tanggal"
                                      : "${DateFormat("d MMMM yyyy", "id_ID").format(state.startDate!)} - ${DateFormat("d MMMM yyyy", "id_ID").format(state.endDate!)}",
                                  style: AppStyle.smallText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {
                                showDateRangePicker(
                                  context: context,
                                  currentDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 1),
                                  locale: Locale('id', "id_ID"),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                ).then((DateTimeRange? dateRange) {
                                  if (dateRange != null) {
                                    state.startDate = dateRange.start;
                                    state.endDate = dateRange.end;
                                    state.days;
                                  }
                                });
                              },
                            ),
                          ),
                          Consumer<OrderProvider>(
                            builder: (context,state1,_){
                              if(state1.withDriver){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text("Sopir", style: AppStyle.smallText),
                                    Consumer<OrderProvider>(
                                      builder:(context,app,_){
                                        if(app.unitDetail!.pemilik.pengemudiList.length <= 0){
                                          return Center(child: Text("Pemilik unit tidak mempunyai supir."),);
                                        }else{
                                          return GridView.count(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                            padding: EdgeInsets.all(2),
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: List.generate(
                                              state.unitDetail!.pemilik.pengemudiList.length,
                                              (index) => Consumer<OrderProvider>(
                                                builder: (context, state, _) => DriverCardWidget(
                                                  user: state.unitDetail!.pemilik.pengemudiList.elementAt(index).user,
                                                  selected: state.selectedDriver == state.unitDetail!.pemilik.pengemudiList.elementAt(index).id,
                                                  onTap: () {
                                                    state.selectedDriver = state.unitDetail!.pemilik.pengemudiList.elementAt(index).id;
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    ),
                                  ],
                                );
                              }else{
                                return SizedBox(height: 10);
                              }
                            },
                          ),
                          
                          SizedBox(height: 10),
                          Text("Total", style: AppStyle.smallText),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(5),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Consumer<OrderProvider>(
                                    builder: (context, state, _) => Text(
                                      "${Helper.toIDR(state.unitDetail!.price)} x ${state.days} Hari",
                                      style: AppStyle.smallText.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Consumer<OrderProvider>(
                                    builder: (context, state, _) => Text(
                                        "Total ${Helper.toIDR(state.unitDetail!.price * state.days)}",
                                        style: AppStyle.smallText),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(color: AppColor.grey, thickness: 6),
                SizedBox(height: 16),
                Text(
                  "Konfirmasi Data Diri Pemesan",
                  style: AppStyle.title3Text,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFieldWithShadow(
                          labelText: "Nama lengkap anda",
                          labelColor: Colors.black,
                          hintText: "Nama Lengkap",
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom nama lengkap wajib diisi';
                            }
                            return null;
                          },
                          onChanged: (value){
                            nama= value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFieldWithShadow(
                          labelText: "Nomor Telepon",
                          labelColor: Colors.black,
                          hintText: "08xxxxxxxxxx",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom nomor telepon wajib diisi';
                            }
                            return null;
                          },
                          onChanged: (value){
                            telp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFieldWithShadow(
                          labelText: "Nomor Induk Kependudukan",
                          labelColor: Colors.black,
                          hintText: "16 Digit NIK",
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom NIK wajib diisi';
                            }
                            return null;
                          },
                          onChanged: (value){
                            nik = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFieldUploadWithShadow(
                          labelText: "Upload Foto KTP",
                          hintText: "Upload",
                          labelColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom upload KTP wajib diisi';
                            }
                            return null;
                          },
                          onFileChanged: (File file) {
                            filePath = file.path;
                            debugPrint(file.path);
                          },
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Divider(color: AppColor.grey, thickness: 6),
                Consumer<AppProvider>(
                  builder:(context,app,_){
                    if(app.homeState == HomeState.Loading){
                      return Center(
                        child: CircularProgressIndicator(color: AppColor.green),
                      );
                    }
                    if(app.homeState == HomeState.Error){
                      return Center(child: Text(defaultErrorText),);
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: BalanceWidget(
                            balance: app.dompet!.saldo,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.topUp);
                            },
                          ),
                        ),
                        Center(child:Text("Pembayaran dengan dompetKu", style: AppStyle.smallText),),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // print(filePath);

                            if (_formKey.currentState!.validate()) {
                              // process here
                              if(state.startDate != null && state.endDate != null && state.address != null && state.lat != null && state.lng != null && filePath != ""){
                                  if(app.dompet!.saldo >= (state.unitDetail!.price * state.days)){
                                    print("oke");
                                    if(state.withDriver){
                                      //dengan driver
                                      if(state.selectedDriver != null){
                                        showLoaderDialog(context);
                                        makeOrderWithDriver(
                                            context,
                                            state.unitDetail!.id,
                                            state.startDate!,
                                            state.endDate!,
                                            nama,
                                            state.address!,
                                            telp,
                                            nik,
                                            state.selectedDriver!,
                                            state.lat!,
                                            state.lng!,
                                            filePath
                                        ).then(
                                          (value){
                                            if(value){
                                              Navigator.pop(context);
                                              Navigator.popUntil(context, (route) => route.isFirst);
                                              Navigator.pushNamed(context, Routes.orderUnitComplete);
                                              Fluttertoast.showToast(msg: "Sukses membuat pemesanan.");
                                            }else{
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(msg: "Gagal membuat pemesanan.");
                                            }
                                          },
                                        );

                                      }else{
                                        alertKolom(context);
                                      }
                                    }else{
                                      //tanpa driver
                                      showLoaderDialog(context);
                                      makeOrderWithoutDriver(
                                          context,
                                          state.unitDetail!.id,
                                          state.startDate!,
                                          state.endDate!,
                                          nama,
                                          state.address!,
                                          telp,
                                          nik,
                                          state.lat!,
                                          state.lng!,
                                          filePath
                                      ).then(
                                        (value){
                                          if(value){
                                            Navigator.pop(context);
                                            Navigator.popUntil(context, (route) => route.isFirst);
                                            Navigator.pushNamed(context, Routes.orderUnitComplete);
                                            Fluttertoast.showToast(msg: "Sukses membuat pemesanan.");
                                          }else{
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(msg: "Gagal membuat pemesanan.");
                                          }
                                        },
                                      );
                                    }
                                  }else{
                                    alertSaldo(context);
                                  }
                              }else{
                                alertKolom(context);
                              }
                            }
                          },
                          child: Text("Pesan Sekarang"),
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  }),
                
              ],
            );
          }),
      );
  }

  Future<bool> makeOrderWithDriver(BuildContext context,int unitId,DateTime startDate,DateTime endDate,String nama, String alamat, String telp,String nik,int pengemudiId,double lat, double long,String filePath) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    Map<String,String> body ={
      'user_id': userId!,
      'kendaraan_id': unitId.toString(),
      'waktu_ambil': startDate.toString(),
      'waktu_kembali': endDate.toString(),
      'name': nama,
      'telp': telp,
      'nik': nik,
      'pengemudi_id': pengemudiId.toString(),
      'alamat': alamat,
      'lat': lat.toString(),
      'long': long.toString()
    };
    bool response = await OrderServices.makeOrder(body, filePath);

    return response;
  }

  Future<bool> makeOrderWithoutDriver(BuildContext context,int unitId,DateTime startDate,DateTime endDate,String nama, String alamat, String telp,String nik,double lat, double long,String filePath) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    Map<String,String> body ={
      'user_id': userId!,
      'kendaraan_id': unitId.toString(),
      'waktu_ambil': startDate.toString(),
      'waktu_kembali': endDate.toString(),
      'name': nama,
      'telp': telp,
      'nik': nik,
      'alamat': alamat,
      'lat': lat.toString(),
      'long': long.toString()
    };
    bool response = await OrderServices.makeOrder(body, filePath);

    return response;
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

  void alertSaldo(BuildContext context) {
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
                "Saldo tidak cukup.",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Silahkan Top Up terlebih dahulu!",
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
