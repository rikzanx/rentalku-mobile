import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/models/unit_detail.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/order_services.dart';

class OrderProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;

  UnitDetail? _unitDetail;
  UnitDetail? get unitDetail => _unitDetail;
  set unitDetail(UnitDetail? unitDetail){
    _unitDetail = unitDetail;
    notifyListeners();
  }

  int _kendaraanId=0;
  int get kendaraanId => _kendaraanId;
  set kendaraanId(int kendaraanId){
    _kendaraanId = kendaraanId;
    notifyListeners();
  }

  Future<void> getUnitDetail(int unitId) async{
    _homeState = HomeState.Loading;
    try {
      ApiResponse<UnitDetail> response = await OrderServices.getUnitDetail(unitId);

      if(response.status){
        _unitDetail = response.data!;

        _homeState = HomeState.Loaded;
      }
    } catch ($e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<bool> makeOrder() async{
    return false;
  }

  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? startDate) {
    _startDate = startDate;
    notifyListeners();
  }

  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  set endDate(DateTime? endDate) {
    _endDate = endDate;
    notifyListeners();
  }

  int get days => _startDate == null || _endDate == null
      ? 0
      : _endDate!.difference(_startDate!).inDays + 1;

  String? _address;
  String? get address => _address;
  set address(String? address) {
    _address = address;
    notifyListeners();
  }

  double? _lat = 0;
  double? get lat => _lat;
  set lat(double? lat){
    _lat = lat;
    notifyListeners();
  }

  double? _lng=0;
  double? get lng=> _lng;
  set lng(double? lng){
    _lng = lng;
    notifyListeners();
  }

  int? _selectedDriver;
  int? get selectedDriver => _selectedDriver;
  set selectedDriver(int? selectedDriver) {
    _selectedDriver = selectedDriver;
    notifyListeners();
  }

  bool _withDriver = false;
  bool get withDriver => _withDriver;
  set withDriver(bool withDriver){
    _withDriver = withDriver;
    notifyListeners();
  } 

  File? _image;
  set image(File? image) {
    _image = image;
    notifyListeners();
  }

  File? get image => _image;

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
