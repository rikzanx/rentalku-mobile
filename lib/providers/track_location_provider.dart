import 'package:flutter/cupertino.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/lokasi.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/unit_services.dart';

class TrackLocationProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;


  Lokasi _location = Lokasi(lat: -7.2974336,long: 112.7448576);
  Lokasi get location => _location;
  set location(Lokasi location){
    _location = location;
    notifyListeners();
  }

  Future getUnitLocation(int unitId) async{
    _homeState = HomeState.Loading;
    try {
      ApiResponse response = await UnitServices.getUnitLocation(unitId);
      if(response.status){
        _location = response.data!;
        _homeState = HomeState.Loaded;
        // notifyListeners();
      }else{
        _homeState = HomeState.Error;
        // notifyListeners();
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