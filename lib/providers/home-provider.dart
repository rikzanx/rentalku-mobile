import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  bool _isFirstTimeHomePageLoads = true;

  void initializeProvider(){
    isFirstTimeHomePageLoads = false;
  }

  bool get isFirstTimeHomePageLoads => _isFirstTimeHomePageLoads;
  set isFirstTimeHomePageLoads(bool isFirstTimeHomePageLoads) {
    this._isFirstTimeHomePageLoads = isFirstTimeHomePageLoads;
    notifyListeners();
  }

}