import 'package:equatable/equatable.dart';
import 'package:rentalku/commons/constants.dart';

class User extends Equatable {
  final int id;
  final String name;
  final UserType userType;
  final String email;
  final DateTime? emailVerifiedAt;
  final String imageURL;
  final String? nik;
  final String? ktpURL;
  final String? simURL;
  final String? address;
  final String? city;
  final String? phone;
  final double? latitude;
  final double? longitude;

  User({
    required this.id,
    required this.name,
    required this.userType,
    required this.email,
    this.emailVerifiedAt,
    required this.imageURL,
    this.nik,
    this.ktpURL,
    this.simURL,
    this.address,
    this.city,
    this.phone,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [id];

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      userType: json['userType'] == 'user' ? UserType.User : UserType.User,
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      imageURL: json['image_link'],
      nik: json['nik'],
      ktpURL: json['foto_ktp'],
      simURL: json['foto_sim'],
      address: json['alamat'],
      city: json['kota'],
      phone: json['telp'],
      latitude: json['lat'],
      longitude: json['long'],
    );
  }
}
