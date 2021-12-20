import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/ulasan_unit.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/ulasan_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UlasanUnitProvider extends ChangeNotifier{
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;

  int _kendaraanId=0;
  int get kendaraanId => _kendaraanId;
  set kendaraanId(int kendaraanId){
    _kendaraanId = kendaraanId;
    notifyListeners();
  }

  UlasanUnit? _ulasanUnit;
  UlasanUnit? get ulasanUnit => _ulasanUnit;
  set ulasanUnit(UlasanUnit? ulasanUnit){
    _ulasanUnit = ulasanUnit;
    notifyListeners();
  }

  UlasanUnit? _ulasanPemilik;
  UlasanUnit? get ulasanPemilik => _ulasanPemilik;
  set ulasanPemilik(UlasanUnit? ulasanPemilik){
    _ulasanPemilik = ulasanPemilik;
    notifyListeners();
  }

  Future<void> getUlasan(int unitId) async{
    _homeState = HomeState.Loading;
    try {
      ApiResponse<UlasanUnit> response = await UlasanServices.getUlasanUnit(unitId);

      if(response.status){
        _ulasanUnit = response.data!;
        _homeState = HomeState.Loaded;
      }else{
        // print(response.message);
        _homeState = HomeState.Error;
      }
    } catch ($e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> getUlasanPemilik(int unitId) async{
    _homeState = HomeState.Loading;
    try {
      ApiResponse<UlasanUnit> response = await UlasanServices.getUlasanPemilik(unitId);

      if(response.status){
        _ulasanPemilik = response.data!;

        _homeState = HomeState.Loaded;
      }else{
        _homeState = HomeState.Loaded;
      }
    } catch ($e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }


  Future<void> getUlasanPemilikByUserId() async{
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString("userId")!;
      ApiResponse<UlasanUnit> response = await UlasanServices.getUlasanPemilikByUserId(userID);

      if(response.status){
        _ulasanPemilik = response.data!;
        _homeState = HomeState.Loaded;
      }else{
        _homeState = HomeState.Loaded;
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