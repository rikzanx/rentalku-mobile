import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
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
}
