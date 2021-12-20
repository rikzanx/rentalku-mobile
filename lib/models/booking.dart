import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/models/user.dart';

class Booking extends Equatable {
  final int id;
  final bool withDriver;
  final DateTime startDate;
  final DateTime endDate;
  final int durasi;
  final String status;
  final String name;
  final String address;
  final String telp;
  final String nik;
  final String fotoKtp;
  final int totalHarga;
  final Unit unit;
  final bool isDoneRating;
  final User pemilik;

  Booking({
    required this.id,
    required this.withDriver,
    required this.startDate,
    required this.endDate,
    required this.durasi,
    required this.status,
    required this.name,
    required this.address,
    required this.telp,
    required this.nik,
    required this.fotoKtp,
    required this.totalHarga,
    required this.unit,
    required this.isDoneRating,
    required this.pemilik,
  });

  int get totalDays => durasi;
  int get totalPrice => totalDays * unit.price;

  @override
  List<Object?> get props => [id];

  factory Booking.fromJson(Map<String,dynamic> json){
    return Booking(
      id: json['id'], 
      withDriver: (json['pengemudi_transaksi'] != null)?true:false, 
      startDate: DateTime.parse(json['waktu_ambil']), 
      endDate: DateTime.parse(json['waktu_kembali']), 
      durasi: json['durasi'],
      status: json['status'],
      name: json['name'],
      address: json['alamat'],
      telp: json['telp'],
      nik: json['nik'],
      fotoKtp: json['foto_ktp'],
      totalHarga: json['total_harga'],
      unit: Unit.fromJson(json['kendaraan']),
      isDoneRating: (json['rating_kendaraan'] != null)?true:false, 
      pemilik: User.fromJson(json['kendaraan']['user']),
      );
  }
}
