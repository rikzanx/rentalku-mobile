import 'package:equatable/equatable.dart';
import 'package:rentalku/commons/constants.dart';

class PaymentMethod extends Equatable {
  final String name;
  final String imageURL;
  final String shortName;
  final String accountName;
  final String accountNumber;
  final PaymentMethodType paymentMethodType;

  PaymentMethod({
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
  List<Object?> get props => [name];

  static List<PaymentMethod> list = [
    PaymentMethod(
        name: "Bank Negara Indonesia",
        imageURL: "bni.png",
        shortName: "BNI",
        accountName: "Alrizdo Adji Junior",
        accountNumber: "0481689987",
        paymentMethodType: PaymentMethodType.BankAccount),
    PaymentMethod(
        name: "Bank Central Asia",
        imageURL: "bca.png",
        paymentMethodType: PaymentMethodType.BankAccount),
    PaymentMethod(
        name: "Bank Rakyat Indonesia",
        imageURL: "bri.png",
        paymentMethodType: PaymentMethodType.BankAccount),
    PaymentMethod(
        name: "GoPay",
        imageURL: "gopay.png",
        paymentMethodType: PaymentMethodType.EWallet),
    PaymentMethod(
        name: "OVO",
        imageURL: "ovo.png",
        paymentMethodType: PaymentMethodType.EWallet),
    PaymentMethod(
        name: "Dana",
        imageURL: "dana.png",
        paymentMethodType: PaymentMethodType.EWallet),
    PaymentMethod(
        name: "ShopeePay",
        imageURL: "shopeepay.png",
        paymentMethodType: PaymentMethodType.EWallet),
  ];
}
