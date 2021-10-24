import 'package:flutter/material.dart';
import 'package:rentalku/models/booking.dart';

class DashboardProvider extends ChangeNotifier{
  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;
  set bottomNavIndex(int bottomNavIndex){
    _bottomNavIndex = bottomNavIndex;
    notifyListeners();
  }
  jumpToPage(int bottomNavIndex){
    _bottomNavIndex = bottomNavIndex;
    _controller.jumpToPage(bottomNavIndex);
    notifyListeners();
  }

  PageController _controller = PageController();
  PageController get controller => _controller;

  int _myBookingIndex = 0;
  int get myBookingIndex => _myBookingIndex;
  set myBookingIndex(int myBookingIndex){
    _myBookingIndex = myBookingIndex;
    notifyListeners();
  }

  List<Booking> _bookings = [];
  List<Booking> get bookings => _bookings;
  set bookings(List<Booking> bookings){
    _bookings = bookings;
    notifyListeners();
  }
}