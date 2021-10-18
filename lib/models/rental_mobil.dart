import 'package:equatable/equatable.dart';

class RentalMobil extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool withDriver;
  final int price;
  final double rating;
  final int capacity;
  final String imageURL;

  RentalMobil({
    required this.id,
    required this.name,
    this.description = "",
    this.withDriver = false,
    this.price = 0,
    this.rating = 0,
    this.capacity = 0,
    required this.imageURL,
  });

  @override
  List<Object?> get props => [id];
}
