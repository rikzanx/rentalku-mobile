import 'package:equatable/equatable.dart';
import 'package:rentalku/models/kategori.dart';

class Unit extends Equatable {
  final int id;
  final String name;
  final String description;
  final bool withDriver;
  final int price;
  final double rating;
  final int capacity;
  final String imageURL;
  final String kategoriName;
  final String transmisi;
  final String warna;
  final String mesin;
  final int tahun;
  final Kategori kategori;
  final String nopol;

  Unit({
    required this.id,
    required this.name,
    this.description = "",
    this.withDriver = true,
    this.price = 0,
    this.rating = 0,
    this.capacity = 0,
    required this.imageURL,
    required this.kategoriName,
    this.transmisi = "",
    this.warna = "",
    this.mesin ="",
    this.tahun = 0,
    this.nopol = "",
    required this.kategori,
  });

  @override
  List<Object?> get props => [id];

  factory Unit.fromJson(Map<String, dynamic> json){
    return Unit(
      id: json['id'],
      name: json['name'],
      price: json['harga'],
      capacity: json['seat'],
      rating: (json['avg_rating'].length > 0)? double.parse(json['avg_rating'][0]['aggregate']):0,
      imageURL: json['image_link'],
      kategoriName: json['kategori']['name'],
      transmisi: json['transmisi'],
      warna: json['warna'],
      mesin: json['mesin'],
      tahun: json['tahun'],
      nopol: json['nopol'],
      kategori: Kategori.fromJson(json['kategori']),
    );
  }
}