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

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      id: json['id'],
      name: json['user']['name'],
      imageURL: json['user']['iamge_link'],
      rating: double.parse(json['jumlah_bintang']),
      text: json['review'],
      dateTime: DateTime.parse(json['created_at'])
    );
  }
}
