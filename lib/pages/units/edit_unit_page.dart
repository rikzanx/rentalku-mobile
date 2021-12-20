import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentalku/commons/colors.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/routes.dart';
import 'package:rentalku/commons/styles.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/providers/form_unit_provider.dart';
import 'package:rentalku/widgets/filter_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_upload_with_shadow_widget.dart';
import 'package:rentalku/widgets/text_field_with_shadow.dart';

final _formKey = GlobalKey<FormState>();
final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
  locale: 'id',
  decimalDigits: 0,
  symbol: "Rp. ",
);
String name = "";
String harga = "";
String kategoriId = "";
String kota = "Surabaya";
String seat = "";
String nopol = "";
String tahun ="";
String transmisi = "";
String mesin = "";
String warna = "";
String filePath ="";

class EditUnitPage extends StatelessWidget {
  final Unit unit;
  const EditUnitPage({Key? key,required this.unit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    name = unit.name;
    harga = unit.price.toString();
    kota = "Surabaya";
    seat = unit.capacity.toString();
    nopol = unit.nopol;
    tahun =unit.tahun.toString();
    transmisi = unit.transmisi;
    mesin = unit.mesin;
    warna = unit.warna;
    filePath ="";

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Ubah Unit Rental"),
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
        body: Consumer<FormUnitProvider>(
          builder: (context,app,_) {
            kategoriId = app.kategoriSelected.toString();
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    children: [
                      Text(
                        "Isi Data Unit Rental",
                        style: AppStyle.title3Text,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Nama Units",
                        hintText: "Honda Jazz",
                        controller: TextEditingController()..text = unit.name,
                        labelColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom nama unit wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Harga Sewa (Rp)/Hari",
                        hintText: "Rp. 0",
                        labelColor: Colors.black,
                        keyboardType: TextInputType.number,
                        controller: TextEditingController()..text = unit.price.toString(),
                        inputFormatters: [_formatter],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom harga sewa wajib diisi';
                          } else if (_formatter.getUnformattedValue() < 10000) {
                            return 'Harga sewa minimal Rp. 10.000';
                          }
                          return null;
                        },
                        onChanged: (value){
                          harga = _formatter.getUnformattedValue().toString();
                        },
                      ),
                      SizedBox(height: 16),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          "Jenis Mobil",
                          style: AppStyle.labelText,
                        ),
                      ),
                      Consumer<FormUnitProvider>(
                        builder: (context,state,_) {
                          if(state.homeState == HomeState.Loading){
                            return Center(child: CircularProgressIndicator(color: AppColor.green,),);
                          }else if(state.homeState == HomeState.Error){
                            return Center(child: Text(defaultErrorText),);
                          }
                          print(state.kategoriSelected);
                          return GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 3,
                              crossAxisCount: 3,
                            ),
                            itemCount: state.kategoriList!.length,
                            itemBuilder: (context, index) => FilterShadowWidget(
                                label: state.kategoriList!.elementAt(index).name,
                                selected: state.kategoriList!.elementAt(index).id == state.kategoriSelected,
                                onTap: (status) {
                                  kategoriId = state.kategoriList!.elementAt(index).id.toString();
                                  state.kategoriSelected = state.kategoriList!.elementAt(index).id;
                                },
                              ),
                            );
                        }
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Transmisi",
                        hintText: "Manual",
                        controller: TextEditingController()..text = unit.transmisi,
                        labelColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom transmisi wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value){
                          transmisi=value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Mesin",
                        hintText: "0",
                        suffixText: "cc",
                        controller: TextEditingController()..text = unit.mesin.substring(0,unit.mesin.length -2),
                        labelColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom mesin wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value){
                          mesin = value+"cc";
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Plat nomor",
                        hintText: "L XXXX ##",
                        labelColor: Colors.black,
                        controller: TextEditingController()..text = unit.nopol,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom plat nomor wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value){
                          nopol = value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Kapasitas Penumpang",
                        hintText: "0",
                        suffixText: "Penumpang",
                        controller: TextEditingController()..text = unit.capacity.toString(),
                        labelColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom kapasitas penumpang wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value){
                          seat = value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Warna mobil",
                        hintText: "Hitam",
                        controller: TextEditingController()..text = unit.warna,
                        labelColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom warna mobil wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value){
                          warna = value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldWithShadow(
                        labelText: "Tahun mobil",
                        hintText: "2021",
                        labelColor: Colors.black,
                        controller: TextEditingController()..text = unit.tahun.toString(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kolom tahun mobil wajib diisi';
                          }
                          return null;
                        },
                        onChanged: (value){
                          tahun = value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFieldUploadWithShadow(
                        labelText: "Upload Foto Mobil",
                        hintText: "Upload",
                        labelColor: Colors.black,
                        validator: (value){
                          return null;
                        },
                        onFileChanged: (File file) {
                          // Provider.of<FormUnitProvider>(context, listen: false)
                          //     .carFile = file;
                          filePath = file.path;
                        },
                      ),
                      SizedBox(height: 16),
                      Consumer<FormUnitProvider>(
                        builder: (context,state,_) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async{
                                print(_formKey.currentState!.validate().toString());
                                if (_formKey.currentState!.validate()) {
                                  if(name != "" && harga != "" && kategoriId != "" && kota != "" && seat != "" && nopol != "" && tahun != "" && transmisi != "" && mesin != "" && warna != ""){
                                    showLoaderDialog(context);
                                    Provider.of<FormUnitProvider>(context, listen: false)
                                    .changeUnit(unit.id,name , harga , kategoriId , kota , seat , nopol , tahun , transmisi , mesin , warna, filePath)
                                    .then((status) {
                                      if(status){
                                        state.getMyUnits();
                                        state.notifyListeners();
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(
                                          context, Routes.editUnitComplete);
                                        Fluttertoast.showToast(msg: "Sukses mengubah unit..");
                                      }else{
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: "Gagal mengubah unit.");
                                      }
                                    }).catchError((msg) {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: defaultErrorText);
                                    });
                                  }else{
                                    print("tidak lengkap2");
                                    alertKolom(context);
                                  }
                                }else{
                                  print("tidak lengkap1");
                                    alertKolom(context);
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
            );
          }
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
