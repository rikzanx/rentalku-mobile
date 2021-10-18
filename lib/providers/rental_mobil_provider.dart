import 'package:flutter/material.dart';

class RentalMobilProvider extends ChangeNotifier {
  List<String> _selectableCity = [
    "Surabaya",
    "Yogyakarta",
    "Jakarta",
    "Bandung",
    "Malang"
  ];
  List<String> get selectableCity => _selectableCity;
  set selectableCity(List<String> selectableCity) {
    _selectableCity = selectableCity;
    notifyListeners();
  }

  List<String> _cities = [];
  List<String> get cities => _cities;
  set cities(List<String> cities) {
    _cities = cities;
    notifyListeners();
  }

  List<String> _selectableSort = [
    "Relevan",
    "Termurah",
    "Termahal",
    "Rating",
    "Terlaris"
  ];
  List<String> get selectableSort => _selectableSort;
  set selectableSort(List<String> selectableSort) {
    _selectableSort = selectableSort;
    notifyListeners();
  }

  String _sort = "Relevan";
  String get sort => _sort;
  set sort(String sort) {
    _sort = sort;
    notifyListeners();
  }

  List<String> _selectableCapacity = ["4", "7", ">7"];
  List<String> get selectableCapacity => _selectableCapacity;
  set selectableCapacity(List<String> selectableCapacity) {
    _selectableCapacity = selectableCapacity;
    notifyListeners();
  }

  List<String> _capacity = [];
  List<String> get capacity => _capacity;
  set capacity(List<String> capacity) {
    _capacity = capacity;
    notifyListeners();
  }

  List<String> _selectableCarType = [
    "Sedan",
    "Crossover",
    "Compact MPV",
    "SUV",
    "Mini MPV"
  ];
  List<String> get selectableCarType => _selectableCarType;
  set selectableCarType(List<String> selectableCarType) {
    _selectableCarType = selectableCarType;
    notifyListeners();
  }

  List<String> _carType = [];
  List<String> get carType => _carType;
  set carType(List<String> carType) {
    _carType = carType;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
