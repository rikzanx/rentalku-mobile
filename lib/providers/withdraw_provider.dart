import 'package:flutter/material.dart';
import 'package:rentalku/models/payment_method.dart';

class WithdrawProvider extends ChangeNotifier {
  int _amount = 0;
  int get amount => _amount;
  set amount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  String _accountNumber = "";
  String get accountNumber => _accountNumber;
  set accountNumber(String accountNumber) {
    _accountNumber = accountNumber;
    notifyListeners();
  }

  PaymentMethod? _paymentMethod;
  PaymentMethod? get paymentMethod => _paymentMethod;
  set paymentMethod(PaymentMethod? paymentMethod) {
    _paymentMethod = paymentMethod;
    notifyListeners();
  }

  bool _bankCollapsed = false;
  bool get bankCollapsed => _bankCollapsed;
  set bankCollapsed(bool bankCollapsed) {
    _bankCollapsed = bankCollapsed;
    notifyListeners();
  }

  List<PaymentMethod> get selectablePaymentMethod => PaymentMethod.list;

  bool get complete => _amount >= 50000 && _paymentMethod != null && _accountNumber.length > 0;
}
