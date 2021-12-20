import 'package:equatable/equatable.dart';
import 'package:rentalku/models/payment_method.dart';

class TopUp extends Equatable {
  final int id;
  final int amount;
  final int uniqueCode;
  final PaymentMethod paymentMethod;

  TopUp({
    required this.id,
    required this.amount,
    required this.uniqueCode,
    required this.paymentMethod,
  });

  int get totalAmount => amount + uniqueCode;

  @override
  List<Object?> get props => [id];

  factory TopUp.fromJson(Map<String, dynamic> json){
    return TopUp(
      id: json['id'],
      amount: json['jumlah'],
      uniqueCode: json['kode_unik'],
      paymentMethod: PaymentMethod.fromJson(json['rekening'])
    );
  }
}
