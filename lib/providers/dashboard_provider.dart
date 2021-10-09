import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier{
  int _bottomNavIndex = 0;
  String? _titleAppBar;

  int get bottomNavIndex => _bottomNavIndex;
  set bottomNavIndex(int bottomNavIndex){
    this._bottomNavIndex = bottomNavIndex;
    switch(bottomNavIndex){
      case 1:
        _titleAppBar = "My Booking";
        break;
      case 2:
        _titleAppBar = "Chat";
        break;
      case 3:
        _titleAppBar = "Profil";
        break;
      default:
        _titleAppBar = null;
        break;
    }

    notifyListeners();
  }

  String? get titleAppBar => _titleAppBar;
}