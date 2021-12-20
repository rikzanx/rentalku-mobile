import 'package:equatable/equatable.dart';
import 'package:rentalku/models/user.dart';

class UnitDetail extends Equatable {
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
  final Pemilik pemilik;

  UnitDetail({
    required this.id,
    required this.name,
    this.description = "",
    this.withDriver = false,
    this.price = 0,
    this.rating = 0,
    this.capacity = 0,
    required this.imageURL,
    required this.kategoriName,
    this.transmisi = "",
    this.warna = "",
    this.mesin ="",
    this.tahun = 0,
    required this.pemilik,
  });

  @override
  List<Object?> get props => [id];

  factory UnitDetail.fromJson(Map<String, dynamic> json,Pemilik pemilik){
    return UnitDetail(
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
      pemilik: pemilik
    );
  }
}

class Pemilik extends Equatable{
  final int id;
  final String name;
  final String imageURL;
  final String city;
  final List<Pengemudi> pengemudiList;

  Pemilik({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.pengemudiList,
    required this.city,
  });  

  @override
  List<Object> get props => [id];

  factory Pemilik.fromJson(Map<String,dynamic> json, List<Pengemudi> pengemudiList){
    return Pemilik(
      id: json['id'],
      name: json['name'],
      imageURL: json['image_link'],
      city: json['kota'],
      pengemudiList: pengemudiList
    );
  }
} 

class Pengemudi extends Equatable{
  final int id;
  final int harga;
  final User user;
  
  Pengemudi({
    required this.id,
    required this.harga,
    required this.user,
  });

  @override
  List<Object> get props => [id];

  factory Pengemudi.fromJson(Map<String,dynamic> json){
    return Pengemudi(
      id: json['id'],
      harga: json['harga'],
      user: User.fromJson(json['user'])
    );
  }
}