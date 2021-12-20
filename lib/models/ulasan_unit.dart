import 'package:equatable/equatable.dart';
import 'package:rentalku/models/review.dart';
import 'package:rentalku/models/user.dart';

class UlasanUnit extends Equatable{
  final int id;
  final double avgRating;
  final List<Rating> ratingList;

  UlasanUnit({
    required this.id,
    required this.avgRating,
    required this.ratingList,
  });

  @override
  List<Object?> get props => [id];

  factory UlasanUnit.fromJson(Map<String,dynamic> json,List<Rating> ratingList){
    return UlasanUnit(
      id: json['id'],
      avgRating: (json['avg_rating'].length > 0)? double.parse(json['avg_rating'][0]['aggregate']):0,
      ratingList: ratingList
    );

  }

}

class Rating extends Equatable{
  final int id;
  final double rating;
  final String review;
  final DateTime dateTime;
  final User user;

  Rating({
    required this.id,
    required this.rating,
    required this.review,
    required this.dateTime,
    required this.user,
  });

  @override
  List<Object?> get props => [id];

  factory Rating.fromJson(Map<String, dynamic> json){
    return Rating(
      id: json['id'],
      rating: double.parse(json['jumlah_bintang'].toString()),
      review: json['review'],
      dateTime: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user'])
    );
  }
}