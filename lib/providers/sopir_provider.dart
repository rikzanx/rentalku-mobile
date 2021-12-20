import 'package:flutter/cupertino.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/sopir_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SopirProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;

  List<User> _drivers = [];
  List<User> get drivers => _drivers;
  set drivers(List<User> drivers){
    _drivers = drivers;
    notifyListeners();
  }

  void getDrivers() async{
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString("userId")!;
      ApiResponse<List<User>> response = await SopirServices.getDrivers(userID);

      if(response.status){
        _drivers = response.data!;
        _homeState = HomeState.Loaded;
        notifyListeners();
      }else{
        _homeState = HomeState.Loaded;
      }
      
    } catch ($e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<bool> registerDriver(String nama, String email, String password, String foto_ktp, String foto_sim) async{
    _homeState= HomeState.Loading;
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString("userId")!;
      Map<String,String> body = {
        'owner_id' : userID,
        'name': nama,
        'password':password,
        'email':email,
      };
      ApiResponse response = await SopirServices.registerDriver(body,foto_ktp,foto_sim);

      if(response.status){
        this.getDrivers();
        _homeState = HomeState.Loaded;
        notifyListeners();
        return true;

      }else{
        _homeState = HomeState.Error;
        notifyListeners();
        return false;
      }

    }catch($e){
      _homeState = HomeState.Error;
      notifyListeners();
      return false;
    }
  }

  @override
  void notifyListeners(){
    super.notifyListeners();
  }

}