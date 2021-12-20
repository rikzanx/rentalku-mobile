import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int id;
  final String title;
  final String? description;
  final DateTime? dateTime;
  final int amount;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.amount,
  });

  @override
  List<Object?> get props => [id];

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      id: json['id'],
      title: json['name'],
      description: json['keterangan'],
      dateTime:json['created_at'] == null ? null : DateTime.tryParse(json['created_at']),
      amount: json['jumlah'],
    );
  }
}
