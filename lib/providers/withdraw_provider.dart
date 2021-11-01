import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rentalku/models/payment_method.dart';

class WithdrawProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: "Rp. ",
  );
  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  int _amount = 0;
  int get amount => _amount;
  set amount(int amount) {
    _amount = amount;

    String _newValue = formatter.format(amount.toString());
    amountController.value = TextEditingValue(
      text: _newValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: _newValue.length),
      ),
    );

    notifyListeners();
  }

  void syncAmount() {
    _amount = formatter.getUnformattedValue().toInt();
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

  List<PaymentMethod> get selectableBankPaymentMethod =>
      PaymentMethod.list.where((element) => element.isBank).toList();

  bool get complete =>
      _amount >= 50000 && _paymentMethod != null && _accountNumber.isNotEmpty;
}
