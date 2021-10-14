import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier{
  int _bottomNavIndex = 0;

  int get bottomNavIndex => _bottomNavIndex;
  set bottomNavIndex(int bottomNavIndex){
    this._bottomNavIndex = bottomNavIndex;
    notifyListeners();
  }
}