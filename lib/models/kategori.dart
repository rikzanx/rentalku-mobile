import 'package:equatable/equatable.dart';

class Kategori extends Equatable {
  final int id;
  final String name;

  Kategori({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];

  factory Kategori.fromJson(Map<String, dynamic> json){
    return Kategori(
      id: json['id'],
      name: json['name'],
    );
  }
}