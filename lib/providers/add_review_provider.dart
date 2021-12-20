import 'package:flutter/material.dart';
import 'package:rentalku/models/booking.dart';

class AddReviewProvider extends ChangeNotifier {
  List<Booking> _bookings = [];
  List<Booking> get bookings => _bookings;
  set bookings(List<Booking> bookings) {
    _bookings = bookings;
    notifyListeners();
  }

  List<double> _ratings = [0, 0, 0];
  List<double> get ratings => _ratings;
  updateRating(int index, double rating) {
    _ratings[index] = rating;
    notifyListeners();
  }

  List<String> _reviews = ["","",""];
  List<String> get reviews => _reviews;
  updateReview(int index,String review){
    _reviews[index] = review;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
