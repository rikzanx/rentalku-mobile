import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  bool get isUser => _user != null && _user!.userType == UserType.User;
  bool get isOwner => _user != null && _user!.userType == UserType.Owner;
  bool get isDriver => _user != null && _user!.userType == UserType.Driver;

  Future<bool> auth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");

    if (accessToken == null) return false;

    ApiResponse<User> response = await AuthServices.getUser(accessToken);

    if (!response.status) return false;

    _user = response.data;
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
  }
}
