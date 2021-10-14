import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int id;
  final String title;
  final String category;
  final String imageURL;

  Article({
    required this.id,
    required this.title,
    required this.category,
    required this.imageURL,
  });

  @override
  List<Object?> get props => [id];
}
