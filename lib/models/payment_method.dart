import 'package:equatable/equatable.dart';
import 'package:rentalku/commons/constants.dart';

class PaymentMethod extends Equatable {
  final int id;
  final String name;
  final String imageURL;
  final String shortName;
  final String accountName;
  final String accountNumber;
  final PaymentMethodType paymentMethodType;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.paymentMethodType,
    this.shortName = "",
    this.accountName = "John Doe",
    this.accountNumber = "12345678",
  });

  bool get isBank => this.paymentMethodType == PaymentMethodType.BankAccount;
  bool get isWallet => this.paymentMethodType == PaymentMethodType.EWallet;

  @override
  List<Object?> get props => [id];

  factory PaymentMethod.fromJson(Map<String, dynamic> json){
    return PaymentMethod(
      id: json['id'],
      name: json['name'],
      imageURL: json['image_link'],
      shortName: json['singkatan'],
      accountName: json['atas_nama'],
      accountNumber: json['no_rek'],
      paymentMethodType: (json['tipe'] == "e-wallet")?PaymentMethodType.EWallet:PaymentMethodType.BankAccount,
    );
  }
}
