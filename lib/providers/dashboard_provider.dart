import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/models/slider_image.dart';
import 'package:rentalku/models/transaction.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/models/unit_detail.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/homepage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;
  // DashboardProvider(){
  //   this.getMyBookings();
  //   this.getMyBookingsDone();
  //   this.getDriverBookings();
  //   this.getDriverBookingsDone();
  //   this.getPemilikBookings();
  //   this.getPemilikBookingsDone();
  // }
  List<Booking> _bookings = [];
  List<Booking> get bookings => _bookings;
  set bookings(List<Booking> bookings) {
    _bookings = bookings;
    notifyListeners();
  }

  List<Booking> _bookingsDone = [];
  List<Booking> get bookingsDone => _bookingsDone;
  set bookingsDone(List<Booking> bookingsDone) {
    _bookingsDone = bookingsDone;
    notifyListeners();
  }

  List<Booking> _pemilikBookings = [];
  List<Booking> get pemilikBookings => _pemilikBookings;
  set pemilikBookings(List<Booking> pemilikBookings) {
    _pemilikBookings = pemilikBookings;
    notifyListeners();
  }

  List<Booking> _pemilikBookingsDone = [];
  List<Booking> get pemilikBookingsDone => _pemilikBookingsDone;
  set pemilikBookingsDone(List<Booking> pemilikBookingsDone) {
    _pemilikBookingsDone = pemilikBookingsDone;
    notifyListeners();
  }

  List<Booking> _driverBookings = [];
  List<Booking> get driverBookings => _driverBookings;
  set driverBookings(List<Booking> driverBookings) {
    _driverBookings = driverBookings;
    notifyListeners();
  }

  List<Booking> _driverBookingsDone = [];
  List<Booking> get driverBookingsDone => _driverBookingsDone;
  set driverBookingsDone(List<Booking> driverBookingsDone) {
    _driverBookingsDone = driverBookingsDone;
    notifyListeners();
  }

  List<Unit> _mostUnits = [];
  List<Unit> get mostUnits => _mostUnits;
  set mostUnits(List<Unit> mostUnits){
    _mostUnits = mostUnits;
    notifyListeners();
  }
  List<SliderImage> _sliderImages = [];
  List<SliderImage> get sliderImages => _sliderImages;
  set sliderImages(List<SliderImage> sliderImages){
    _sliderImages = sliderImages;
    notifyListeners();
  }
  
  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;
  set bottomNavIndex(int bottomNavIndex) {
    _bottomNavIndex = bottomNavIndex;
    print(bottomNavIndex);
    notifyListeners();
  }

  jumpToPage(int bottomNavIndex) {
    _bottomNavIndex = bottomNavIndex;
    _controller.jumpToPage(bottomNavIndex);
    
    notifyListeners();
  }

  PageController _controller = PageController();
  PageController get controller => _controller;

  int _myBookingIndex = 0;
  int get myBookingIndex => _myBookingIndex;
  set myBookingIndex(int myBookingIndex) {
    _myBookingIndex = myBookingIndex;
    notifyListeners();
  }

  User? _pengemudi;
  User? get pengemudi => _pengemudi;
  set pengemudi(User? pengemudi){
    _pengemudi = pengemudi;
    notifyListeners();
  }

  Future<void> getMostUnits() async {
    _homeState = HomeState.Loading;
    try {
      ApiResponse<List<Unit>> response = await HomepageServices.getMostUnits();

      if(response.status){
        List<Unit> mostUnits = response.data!;
        _mostUnits = mostUnits;
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      _homeState = HomeState.Error;
    }
      
    notifyListeners();
  }

  Future<void> getSliderImages() async {
    _homeState = HomeState.Loading;
    try {
      ApiResponse<List<SliderImage>> response = await HomepageServices.getSliderImages();

      if(response.status){
        print("oke");
        List<SliderImage> sliderImages = response.data!;
        _sliderImages = sliderImages;
        _homeState = HomeState.Loaded;
        notifyListeners(); 
      }      
    } catch ($e) {
      print($e);
      _homeState = HomeState.Error;
    }
    notifyListeners(); 
  }
  
  Future<void> getMyBookings() async {
    _homeState = HomeState.Loading;
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      ApiResponse<List<Booking>> response = await HomepageServices.getMyBookings(userID!);

      if(response.status){
        List<Booking> bookings = response.data!;
        _bookings = bookings;
        print("dapat booking");
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      print("gak dapat booking");
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> getMyBookingsDone() async {
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      ApiResponse<List<Booking>> response = await HomepageServices.getMyBookingsDone(userID!);

      if(response.status){
        List<Booking> bookingsDone = response.data!;
        _bookingsDone = bookingsDone;
        print("dapat booking");
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      print("gak dapat booking");
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
  Future<void> getPemilikBookings() async {
    _homeState = HomeState.Loading;
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      ApiResponse<List<Booking>> response = await HomepageServices.getPemilikBookings(userID!);

      if(response.status){
        List<Booking> pemilikBookings = response.data!;
        _pemilikBookings = pemilikBookings;
        print("dapat booking");
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      print("gak dapat booking");
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> getPemilikBookingsDone() async {
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      ApiResponse<List<Booking>> response = await HomepageServices.getPemilikBookingsDone(userID!);

      if(response.status){
        List<Booking> pemilikBookingsDone = response.data!;
        _pemilikBookingsDone = pemilikBookingsDone;
        print("dapat booking");
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      print("gak dapat booking");
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> getDriverBookings() async {
    _homeState = HomeState.Loading;
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      ApiResponse<List<Booking>> response = await HomepageServices.getDriverBookings(userID!);

      if(response.status){
        List<Booking> driverBookings = response.data!;
        _driverBookings = driverBookings;
        print("dapat booking");
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      print("gak dapat booking");
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> getDriverBookingsDone() async {
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userID = prefs.getString("userId");
      ApiResponse<List<Booking>> response = await HomepageServices.getDriverBookingsDone(userID!);

      if(response.status){
        List<Booking> driverBookingsDone = response.data!;
        _driverBookingsDone = driverBookingsDone;
        print("dapat booking");
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      print("gak dapat booking");
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }


  Future<void> getPengemudi(int transaksiId) async{
    _homeState = HomeState.Loading;
    try {
      ApiResponse<User> response = await HomepageServices.getPengemudi(transaksiId.toString());

      if(response.status){
        User pengemudi = response.data!;
        _pengemudi = pengemudi;
      } 
      _homeState = HomeState.Loaded;
    } catch ($e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}