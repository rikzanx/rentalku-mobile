import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/search_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchUnitsProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;

  HomeState get homeState => _homeState;
  // SearchUnitsProvider(){
  //   print("ini search unit consturtor");
  //   _unitList=[];
  //   _isloading = true;
  //   this.getUnits(this._query,this._category);
  //   this.getKategori();
  // }
  bool? _isloading;
  bool? get isloading => _isloading;
  set isloading(bool? isloading){
    _isloading = isloading;
    notifyListeners();
  }
  
  List<Unit>? _unitList =[];
  List<Unit>? get unitList => _unitList;
  set unitList(List<Unit>? unitList) {
    _unitList = unitList;
    notifyListeners();
  }
  
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    print(selectedIndex);
    notifyListeners();
  }

  String _query = "";
  String get query => _query;
  set query(String query){
    _query = query;
    notifyListeners();
  }

  List<String> _category = [];
  List<String> get category => _category;
  void addCategory(String category){
    _category.add(category);
    notifyListeners();
  }

  List<String> _pilihanKota = ["Surabaya","Jakarta","Bandung","Semarang"];
  List<String> get pilihanKota => _pilihanKota;
  void addpilihanKota(String pilihanKota){
    _pilihanKota.add(pilihanKota);
    notifyListeners();
  }

  String _kota = "";
  String get kota => _kota;
  set kota(String kota) {
    _kota = kota;
    notifyListeners();
  }

  void search(){
    print(this.kota);
    this.getKategori();
    this.getUnits(this._query, this._carType,this.kota);
  }

  changeUnit(int selectedIndex) {
    _selectedIndex = selectedIndex;
    print(selectedIndex);
    notifyListeners();
  }


  Future<void> getUnits(String query, List<String> category,String kota) async {
    _homeState = HomeState.Loading;
    try{
      ApiResponse<List<Unit>> response = await SeacrhServices.getUnits(query,category,kota);

      if(response.status){
        _unitList = response.data!;
        _isloading = false;
        
        _homeState = HomeState.Loaded;
      }
    }catch($e){
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> getKategori() async {
    _homeState = HomeState.Loading;
    try{
      ApiResponse<List<String>> response = await SeacrhServices.getKategori();

      if(response.status){
        _selectableCarType = response.data!;
        
        _homeState = HomeState.Loaded;
      }
    }catch($e){
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<Unit> getUnitDetail() async{
    Unit selected = _unitList![_selectedIndex];
    return selected;
  }
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

  List<String> _selectableCarType = [];
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
