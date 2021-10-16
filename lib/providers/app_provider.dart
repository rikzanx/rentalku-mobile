import 'package:flutter/material.dart';
import 'package:rentalku/commons/types.dart';

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

  UserType _userType = UserType.User;
  UserType get userType => _userType;
  set userType(UserType userType) {
    _userType = userType;
    notifyListeners();
  }
}
