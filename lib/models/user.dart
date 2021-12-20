import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:rentalku/commons/constants.dart';

class User extends Equatable {
  final int id;
  final String name;
  final UserType userType;
  final String email;
  final DateTime? emailVerifiedAt;
  final String imageURL;
  final String tanggalLahir;
  final String? nik;
  final String? ktpURL;
  final String? simURL;
  final String? address;
  final String? city;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final double rating;

  User({
    required this.id,
    required this.name,
    required this.userType,
    required this.email,
    this.emailVerifiedAt,
    required this.imageURL,
    this.tanggalLahir ="",
    this.nik,
    this.ktpURL,
    this.simURL,
    this.address,
    this.city,
    this.phone,
    this.latitude,
    this.longitude,
    this.rating = 0,
  });

  @override
  List<Object?> get props => [id];

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      userType: json['role'] == 'pengemudi' ? UserType.Driver : (json['role'] == 'user' ? UserType.User : UserType.Owner),
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] == null ? null : DateTime.tryParse(json['email_verified_at']),
      imageURL: json['image_link'],
      tanggalLahir: (json['tanggal_lahir'] != null)? DateFormat('yyyy-MM-dd').format(DateTime.parse(json['tanggal_lahir'])):json['tanggal_lahir'].toString(),
      nik: json['nik'],
      ktpURL: json['foto_ktp'],
      simURL: json['foto_sim'],
      address: json['alamat'],
      city: json['kota'],
      phone: json['telp'],
      latitude: json['lat'],
      longitude: json['long'],
      rating: (json.containsKey("avg_rating"))?(json['avg_rating'].length > 0)? double.parse(json['avg_rating'][0]['aggregate']):0:0,
    );
  }
}
