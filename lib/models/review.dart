import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int id;
  final String name;
  final String imageURL;
  final double rating;
  final String text;
  final DateTime dateTime;

  Review({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.rating,
    required this.text,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [id];
}
