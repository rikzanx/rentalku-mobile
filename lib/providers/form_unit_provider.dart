import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';

class FormUnitProvider extends ChangeNotifier {
  File? _carFile;
  File? get carFile => _carFile;
  set carFile(File? carFile) {
    _carFile = carFile;
    notifyListeners();
  }

  String? _name;
  String? get name => _name;
  set name(String? name) {
    _name = name;
    notifyListeners();
  }

  String _carType = carTypes.first;
  String get carType => _carType;
  set carType(String carType) {
    _carType = carType;
    notifyListeners();
  }

  bool _carDriverType = false;
  bool get carDriverType => _carDriverType;
  set carDriverType(bool carDriverType) {
    _carDriverType = carDriverType;
    notifyListeners();
  }
}
