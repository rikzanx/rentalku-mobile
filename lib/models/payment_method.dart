import 'package:equatable/equatable.dart';
import 'package:rentalku/commons/variables.dart';

class PaymentMethod extends Equatable {
  final String name;
  final String imageURL;
  final PaymentMethodType paymentMethodType;

  PaymentMethod({
    required this.name,
    required this.imageURL,
    required this.paymentMethodType,
  });

  @override
  List<Object?> get props => [name];
}
