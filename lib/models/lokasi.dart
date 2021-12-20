import 'package:equatable/equatable.dart';
import 'package:rentalku/models/kategori.dart';

class Lokasi extends Equatable {
  final double lat;
  final double long;

  Lokasi({
    required this.lat,
    required this.long
  });

  @override
  List<Object?> get props => [lat];

  factory Lokasi.fromJson(Map<String, dynamic> json){
    return Lokasi(
      lat: double.parse(json['lat']),
      long: double.parse(json['long'])
    );
  }
}