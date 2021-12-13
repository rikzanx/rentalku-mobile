import 'package:equatable/equatable.dart';

class Dompet extends Equatable {
  final int id;
  final int saldo;

  Dompet({
    required this.id,
    required this.saldo
  });

  @override
  List<Object?> get props => [id];

  factory Dompet.fromJson(Map<String, dynamic> json){
    return Dompet(
      id: json['id'],
      saldo: json['saldo']
    );
  }
}
