import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';

class AppProvider extends ChangeNotifier {
  bool _isFirstTimeHomePageLoads = true;

  void initializeProvider() {
    isFirstTimeHomePageLoads = false;
  }

  bool get isFirstTimeHomePageLoads => _isFirstTimeHomePageLoads;
  set isFirstTimeHomePageLoads(bool isFirstTimeHomePageLoads) {
    this._isFirstTimeHomePageLoads = isFirstTimeHomePageLoads;
    notifyListeners();
  }

  UserType _userType = UserType.Owner;
  UserType get userType => _userType;
  bool get isUser => _userType == UserType.User;
  bool get isOwner => _userType == UserType.Owner;
  bool get isDriver => _userType == UserType.Driver;
  set userType(UserType userType) {
    _userType = userType;
    notifyListeners();
  }
}
