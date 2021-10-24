import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrderProvider extends ChangeNotifier {
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? startDate) {
    _startDate = startDate;
    notifyListeners();
  }

  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  set endDate(DateTime? endDate) {
    _endDate = endDate;
    notifyListeners();
  }

  int get days => _startDate == null || _endDate == null
      ? 0
      : _endDate!.difference(_startDate!).inDays + 1;

  String? _address;
  String? get address => _address;
  set address(String? address) {
    _address = address;
    notifyListeners();
  }

  int? _selectedDriver;
  int? get selectedDriver => _selectedDriver;
  set selectedDriver(int? selectedDriver) {
    _selectedDriver = selectedDriver;
    notifyListeners();
  }

  File? _image;
  Future getImage(ImageSource media) async {
    XFile? img = await ImagePicker().pickImage(source: media);
    if (img != null) {
      _image = File(img.path);
      notifyListeners();
    }
  }
  File? get image => _image;
}
