import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool withDriver;
  final int price;
  final String imageURL;
  final DateTime startDate;
  final DateTime endDate;
  final String address;

  Booking({
    required this.id,
    required this.name,
    required this.description,
    required this.withDriver,
    required this.price,
    required this.imageURL,
    required this.startDate,
    required this.endDate,
    required this.address,
  });

  int get totalDays => endDate.difference(startDate).inDays;
  int get totalPrice => totalDays * price;

  @override
  List<Object?> get props => [id];
}
