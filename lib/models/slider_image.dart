import 'package:equatable/equatable.dart';

class SliderImage extends Equatable {
  final int id;
  final String imageURL;

  SliderImage({
    required this.id,
    required this.imageURL,
  });

  @override
  List<Object?> get props => [id];

  factory SliderImage.fromJson(Map<String, dynamic> json){
    return SliderImage(
      id: json['id'],
      imageURL: json['image'],
    );
  }
}
