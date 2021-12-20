import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/kategori.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/pages/profile/upgrade_owner_car_page.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/search_service.dart';
import 'package:rentalku/services/ulasan_services.dart';
import 'package:rentalku/services/unit_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormUnitProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;

  HomeState get homeState => _homeState;

  File? _carFile;
  File? get carFile => _carFile;
  set carFile(File? carFile) {
    _carFile = carFile;
    notifyListeners();
  }

  // String? _name;
  // String? get name => _name;
  // set name(String? name) {
  //   _name = name;
  //   notifyListeners();
  // }

  String _carType = carTypes.first;
  String get carType => _carType;
  set carType(String carType) {
    _carType = carType;
    notifyListeners();
  }

  int _kategoriSelected = 0;
  int get kategoriSelected => _kategoriSelected;
  set kategoriSelected(int kategoriSelected){
    _kategoriSelected = kategoriSelected;
    notifyListeners();
  }

  List<Kategori>? _kategoriList;
  List<Kategori>? get kategoriList => _kategoriList;
  set kategoriList(List<Kategori>? kategoriList){
    _kategoriList = kategoriList;
    notifyListeners();
  }

  List<Unit>? _myUnitList =[];
  List<Unit>? get myUnitList => _myUnitList;
  set myUnitList(List<Unit>? myUnitList) {
    _myUnitList = myUnitList;
    notifyListeners();
  }

  bool _carDriverType = false;
  bool get carDriverType => _carDriverType;
  set carDriverType(bool carDriverType) {
    _carDriverType = carDriverType;
    notifyListeners();
  }

  String _name = "";
  String get name=>_name;
  set name(String name){
    _name = name;
    notifyListeners();
  }
  String _harga = "";
  String get harga=>_harga;
  set harga(String harga){
    _harga = harga;
    notifyListeners();
  }
  String _seat = "";
  String get seat=>_seat;
  set seat (String seat){
    _seat = seat;
    notifyListeners();
  }
  String _nopol = "";
  String get nopol=>_nopol;
  set nopol(String nopol){
    _nopol = nopol;
    notifyListeners();
  }
  String _tahun ="";
  String get tahun=>_tahun;
  set tahun (String tahun){
    _tahun = tahun;
    notifyListeners();
  }
  String _transmisi = "";
  String get transmisi=>_transmisi;
  set transmisi(String transmisi){
    _transmisi = transmisi;
    notifyListeners();
  }
  String _mesin = "";
  String get mesin=>_mesin;
  set mesin(Stringmesin){
    _mesin = mesin;
    notifyListeners();
  }
  String _warna = "";
  String get warna=> _warna;
  set warna (String warna){
    _warna = warna;
    notifyListeners();
  }
  String _filePath ="";
  String get filePath=> _filePath;
  set filePath (String filePath){
    _filePath = filePath;
    notifyListeners();
  }

  Future<void> getMyUnits() async {
    _homeState = HomeState.Loading;
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      ApiResponse<List<Unit>> response = await SeacrhServices.getMyUnits(userID!);

      if(response.status){
        _myUnitList = response.data!;
        _homeState = HomeState.Loaded;
      }
    }catch($e){
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<bool> registerUnit(String name ,String harga ,String kategoriId ,String kota ,String seat ,String nopol ,String tahun,String transmisi ,String mesin ,String warna ,String filePath) async{
    _homeState = HomeState.Loading;
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      Map<String, String> body = {
        'user_id': userID!,
        'kategori_id': kategoriId,
        'name': name,
        'kota': kota,
        'seat': seat,
        'nopol': nopol,
        'harga': harga,
        'tahun': tahun,
        'transmisi': transmisi,
        'mesin': mesin,
        'warna': warna,
        'supir': "1"
      };
      ApiResponse<Unit> response = await UnitServices.registerUnit(body,filePath);

      if(response.status){
        _homeState = HomeState.Loaded;
        notifyListeners();
        return true;
      }else{
        return false;
      }
    }catch($e){
      _homeState = HomeState.Error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> changeUnit(int unitId,String name ,String harga ,String kategoriId ,String kota ,String seat ,String nopol ,String tahun,String transmisi ,String mesin ,String warna ,String filePath) async{
    _homeState = HomeState.Loading;
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      Map<String, String> body = {
        'user_id': userID!,
        'kategori_id': kategoriId,
        'name': name,
        'kota': kota,
        'seat': seat,
        'nopol': nopol,
        'harga': harga,
        'tahun': tahun,
        'transmisi': transmisi,
        'mesin': mesin,
        'warna': warna,
        'supir': "1"
      };
      bool withImage = false;
      ApiResponse<Unit> response;
      if(filePath != ""){
         withImage = true;
        response = await UnitServices.changeUnit(unitId,body,withImage,filePath:filePath);
      }else{
        response = await UnitServices.changeUnit(unitId,body,withImage);
      }

      if(response.status){
        _homeState = HomeState.Loaded;
        notifyListeners();
        return true;
      }else{
        return false;
      }
    }catch($e){
      _homeState = HomeState.Error;
      notifyListeners();
      return false;
    }
  }

  void getKategoriList() async{
    _homeState = HomeState.Loading;
    try {
      ApiResponse<List<Kategori>> response = await UnitServices.getKategoriList();

      if(response.status){
        _kategoriList = response.data!;

        _homeState = HomeState.Loaded;
      }else{
        _homeState = HomeState.Error;
      }
    } catch ($e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
