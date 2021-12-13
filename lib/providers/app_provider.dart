import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/dompet.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/auth_services.dart';
import 'package:rentalku/services/dompet_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class AppProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  Dompet? _dompet;
  Dompet? get dompet => _dompet;
  set dompet(Dompet? dompet) {
    _dompet = dompet;
    notifyListeners();
  }

  bool get isUser => _user != null && _user!.userType == UserType.User;
  bool get isOwner => _user != null && _user!.userType == UserType.Owner;
  bool get isDriver => _user != null && _user!.userType == UserType.Driver;

  Future getNameUser() async{
    return _user!.name;
  }
  Future getImageUser() async{
    return _user!.imageURL;
  }
  Future getSaldo() async{
    int userId = _user!.id;
    ApiResponse<int> response = await DompetServices.getSaldo(userId);
    inspect(response);
    if(!response.status) return throw response.message!;
    // String saldo = response.data!;
    return response.data!;
  }
  Future<bool> auth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");

    if (accessToken == null) return false;

    ApiResponse<User> response = await AuthServices.getUser(accessToken);

    if (!response.status) return false;
    
    // prefs.setString('user',jsonEncode(response.data));
    _user = response.data;

    ApiResponse<Dompet> response2 = await DompetServices.getDompet(_user!.id);

    if (!response2.status) return false;

    _dompet = response2.data;

    return true;
  }

  Future login(String email, String password) async {
    ApiResponse<String> res1 = await AuthServices.signIn(email, password);

    if (!res1.status) throw res1.message!;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", res1.data!);

    ApiResponse<User> res2 = await AuthServices.getUser(res1.data!);

    if (!res2.status) throw res2.message!;

    _user = res2.data;

    ApiResponse<Dompet> response3 = await DompetServices.getDompet(_user!.id);

    if (!response3.status) throw response3.message!;

    _dompet = response3.data;
  }

  Future logout() async {
    ApiResponse response = await AuthServices.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("accessToken");
  }

  Future daftar(String name, String email, String password) async {
    ApiResponse response1 = await AuthServices.signUp(name,email,password);

    if(!response1.status) throw response1.message!;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", response1.data!);

    ApiResponse response2 = await AuthServices.getUser(response1.data!);

    if(!response2.status) throw response2.message!;
    
    _user = response2.data;

    ApiResponse<Dompet> response3 = await DompetServices.getDompet(_user!.id);

    if (!response3.status) throw response3.message!;

    _dompet = response3.data;
  }
}
