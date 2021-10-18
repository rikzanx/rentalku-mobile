import 'package:flutter/material.dart';
import 'package:rentalku/models/booking.dart';

class AddReviewProvider extends ChangeNotifier {
  List<Booking> _bookings = List.generate(
    4,
    (index) => Booking(
      id: 1,
      name: "Toyota Innova Reborn",
      description: "Compact MPV",
      withDriver: true,
      price: 500000,
      imageURL: "https://i.imgur.com/vtUhSMq.png",
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 2)),
      address: "Jl. Anjasmoro No. 2, Waru, Sidoarjo",
    ),
  );
  List<Booking> get bookings => _bookings;
  set bookings(List<Booking> bookings) {
    _bookings = bookings;
    notifyListeners();
  }

  List<double> _ratings = [0, 0, 0, 0];
  List<double> get ratings => _ratings;
  updateRating(int index, double rating) {
    _ratings[index] = rating;
    notifyListeners();
  }
}
