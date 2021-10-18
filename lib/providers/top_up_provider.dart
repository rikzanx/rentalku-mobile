import 'package:flutter/material.dart';
import 'package:rentalku/commons/types.dart';
import 'package:rentalku/models/payment_method.dart';

class TopUpProvider extends ChangeNotifier {
  int _amount = 0;
  int get amount => _amount;
  set amount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  PaymentMethod? _paymentMethod;
  PaymentMethod? get paymentMethod => _paymentMethod;
  set paymentMethod(PaymentMethod? paymentMethod) {
    _paymentMethod = paymentMethod;
    notifyListeners();
  }

  bool _walletCollapsed = true;
  bool _bankCollapsed = false;
  bool get walletCollapsed => _walletCollapsed;
  bool get bankCollapsed => _bankCollapsed;
  set walletCollapsed(bool walletCollapsed) {
    _walletCollapsed = walletCollapsed;
    notifyListeners();
  }

  set bankCollapsed(bool bankCollapsed) {
    _bankCollapsed = bankCollapsed;
    notifyListeners();
  }

  List<int> get selectableAmount =>
      [20000, 50000, 100000, 200000, 300000, 500000];
  List<PaymentMethod> get selectablePaymentMethod => PaymentMethod.list;
}
