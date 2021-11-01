import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rentalku/models/payment_method.dart';

class TopUpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: "Rp. ",
  );
  final TextEditingController amountController = TextEditingController();

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

  bool _walletCollapsed = true;
  bool get walletCollapsed => _walletCollapsed;
  set walletCollapsed(bool walletCollapsed) {
    _walletCollapsed = walletCollapsed;
    notifyListeners();
  }

  List<int> get selectableAmount =>
      [20000, 50000, 100000, 200000, 300000, 500000];
  List<PaymentMethod> get selectableBankPaymentMethod =>
      PaymentMethod.list.where((element) => element.isBank).toList();
  List<PaymentMethod> get selectableWalletPaymentMethod =>
      PaymentMethod.list.where((element) => element.isWallet).toList();

  bool get complete => _amount >= 10000 && _paymentMethod != null;
}
