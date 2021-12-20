import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/dompet.dart';
import 'package:rentalku/models/transaction.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/pages/profile/update_password_page.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/auth_services.dart';
import 'package:rentalku/services/dompet_services.dart';
import 'package:rentalku/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class AppProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;

  
  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  List<Unit> _mostUnits = [];

  List<Unit> get mostUnits {
    return _mostUnits;
  }

  set mostUnits(List<Unit> mostUnits){
    _mostUnits = mostUnits;
    notifyListeners();
  }

  Dompet? _dompet;
  Dompet? get dompet => _dompet;
  set dompet(Dompet? dompet) {
    _dompet = dompet;
    notifyListeners();
  }

  List<Transaction>? _transactionList;
  List<Transaction>? get transactionList => _transactionList;
  set transactionList(List<Transaction>? transaction) {
    _transactionList = transactionList;
    notifyListeners();
  }
  bool _isUser = true;
  bool _isOwner = false;
  bool _isDriver = false;
  bool get isUser => _isUser;
  bool get isOwner => _isOwner;
  bool get isDriver => _isDriver;

  void changetoUser(){
    _isUser = true;
    _isOwner = false;
    _isDriver= false;
    notifyListeners();
  }

   void changetoOwner(){
    _isUser = false;
    _isOwner = true;
    _isDriver= false;
    notifyListeners();
  }

   void changetoDriver(){
    _isUser = false;
    _isOwner = false;
    _isDriver= true;
    notifyListeners();
  }

  List<String> _pilihanKota = ["Surabaya","Jakarta","Bandung","Semarang"];
  List<String> get pilihanKota => _pilihanKota;
  void addpilihanKota(String pilihanKota){
    _pilihanKota.add(pilihanKota);
    notifyListeners();
  }

  String _kota = "";
  String get kota => _kota;
  set kota(String kota) {
    _kota = kota;
    notifyListeners();
  }

  Future setKota() async{
    _kota = user!.city!;
    notifyListeners();
  }

  Future<bool> changeLocation(String kota) async{
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString("userId");
      ApiResponse response = await UserServices.changeLocation(userId!, kota);

      if(response.status){
        _user = response.data;
        _homeState = HomeState.Loaded;
        notifyListeners();
        return true;
      }else{
        _homeState = HomeState.Error;
        notifyListeners();
        return false;
      }
    } catch ($e) {
      print("provider");
      print($e);
      _homeState = HomeState.Error;
      notifyListeners();
      return false;
    }
  }

  Future getNameUser() async{
    return _user!.name;
  }
  Future getImageUser() async{
    return _user!.imageURL;
  }
  Future<void> getSaldo() async{
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString("accessToken");
      if (accessToken != null){
        ApiResponse<User> response = await AuthServices.getUser(accessToken);
        if (response.status) {
            // prefs.setString('user',jsonEncode(response.data));
            int userId =  response.data!.id;
            ApiResponse<Map<String,dynamic>> response2 = await DompetServices.getSaldo(userId);
            if(response2.status){
              // String saldo = response.data!;
              List<Transaction> transactionList = new List.empty(growable: true);
              var jsonlist = response2.data!['transaksi_dompet'] as List;
              jsonlist.forEach((e) {
                    transactionList.add(Transaction.fromJson(e));
                  });
              _transactionList = transactionList;
              Dompet dompet = Dompet.fromJson(response2.data!);
              _dompet = dompet;
              _homeState = HomeState.Loaded;

            }
        }
      }
    } catch (e) {
      _homeState = HomeState.Error;
      print(e);
    }
    notifyListeners();
  }
  Future<bool> auth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");

    if (accessToken == null) return false;

    ApiResponse<User> response = await AuthServices.getUser(accessToken);

    if (!response.status) return false;
    
    // prefs.setString('user',jsonEncode(response.data));
    if(response.data!.userType == UserType.Owner){
      this.changetoOwner();
    }
    if(response.data!.userType == UserType.Driver){
      this.changetoDriver();
    }
    if(response.data!.userType == UserType.User){
      this.changetoUser();
    }
    _user = response.data;


    return true;
  }

  Future<bool> changeImage(String filePath) async {
    Map<String,String> body = {
      'user_id' : _user!.id.toString(),
    };
    ApiResponse<User> response = await UserServices.changeImage(body,filePath);

    if(!response.status) return false;

    _user = response.data;
    notifyListeners();
    return true;
  }

  Future<bool> changeUser(String nama, String alamat, String tanggal_lahir, String telp) async {
    String userId = _user!.id.toString();
    ApiResponse<User> response = await UserServices.changeUser(userId,nama,alamat,tanggal_lahir,telp);

    if(!response.status) return false;

    _user = response.data;
    notifyListeners();
    return true;
  }

  Future<bool> changePassword(String password, String passwordNew) async {
    String userId = _user!.id.toString();
    ApiResponse<User> response = await UserServices.changePassword(userId,password,passwordNew);

    if(!response.status) return false;

    _user = response.data;
    notifyListeners();
    return true;
  }

  Future login(String email, String password) async {
    ApiResponse<String> res1 = await AuthServices.signIn(email, password);

    if (!res1.status) throw res1.message!;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", res1.data!);

    ApiResponse<User> res2 = await AuthServices.getUser(res1.data!);
    if (!res2.status) throw res2.message!;

    prefs.setString("userId", res2.data!.id.toString());

    if(res2.data!.userType == UserType.Owner){
      this.changetoOwner();
    }
    if(res2.data!.userType == UserType.Driver){
      ApiResponse response = await AuthServices.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("accessToken");
      prefs.remove("userId");
      throw "Anda belum terdaftar";
      // this.changetoDriver();
    }
    if(res2.data!.userType == UserType.User){
      this.changetoUser();
    }

    _user = res2.data;
    notifyListeners();
  }

  Future loginDriver(String email, String password) async {
    ApiResponse<String> res1 = await AuthServices.signIn(email, password);

    if (!res1.status) throw res1.message!;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", res1.data!);

    ApiResponse<User> res2 = await AuthServices.getUser(res1.data!);
    if (!res2.status) throw res2.message!;

    prefs.setString("userId", res2.data!.id.toString());

    if(res2.data!.userType == UserType.Owner){
      // this.changetoOwner();
      ApiResponse response = await AuthServices.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("accessToken");
      prefs.remove("userId");
      throw "Anda belum terdaftar";
    }
    if(res2.data!.userType == UserType.Driver){
      this.changetoDriver();
    }
    if(res2.data!.userType == UserType.User){
      // this.changetoUser();
      ApiResponse response = await AuthServices.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("accessToken");
      prefs.remove("userId");
      throw "Anda belum terdaftar";
    }

    _user = res2.data;
    notifyListeners();
  }

  Future logout() async {
    ApiResponse response = await AuthServices.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("accessToken");
    prefs.remove("userId");
  }

  Future daftar(String name, String email, String password) async {
    ApiResponse response1 = await AuthServices.signUp(name,email,password);

    if(!response1.status) throw response1.message!;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", response1.data!);

    ApiResponse response2 = await AuthServices.getUser(response1.data!);

    if(!response2.status) throw response2.message!;
    prefs.setString("userId", response2.data!.id.toString());

    if(response2.data!.userType == UserType.Owner){
      this.changetoOwner();
    }
    if(response2.data!.userType == UserType.Driver){
      this.changetoDriver();
    }
    if(response2.data!.userType == UserType.User){
      this.changetoUser();
    }
    
    _user = response2.data;
  }

  Future<bool> registerOwner(String name,String nik,String filePath) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    Map<String,String> body = {
      'id': userId!,
      'name' : name,
      'nik' : nik,
    };
    ApiResponse<User> response = await UserServices.registerOwner(body, filePath);

    if(response.status){
      _user = response.data;
      if(response.data!.userType == UserType.Owner){
        this.changetoOwner();
      }
      if(response.data!.userType == UserType.Driver){
        this.changetoDriver();
      }
      if(response.data!.userType == UserType.User){
        this.changetoUser();
      }
      notifyListeners();
      return true;
    }else{
      return false;
      
    }
  }
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
