import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/payment_method.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/dompet_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;
  final formKey = GlobalKey<FormState>();
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: "Rp. ",
  );
  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();

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

  String _accountName = "";
  String get accountName => _accountName;
  set accountName(String accountName) {
    _accountName = accountName;
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
  List<PaymentMethod>? _paymentMethodList = [];
  List<PaymentMethod>? get paymentMethodList => _paymentMethodList;
  set paymentMethodList(List<PaymentMethod>? paymentMethodList){
    _paymentMethodList = paymentMethodList;
    notifyListeners();
  }
  List<PaymentMethod> get selectableBankPaymentMethod =>
      _paymentMethodList!.where((element) => element.isBank).toList();
  List<PaymentMethod> get selectableWalletPaymentMethod =>
      _paymentMethodList!.where((element) => element.isWallet).toList();

  bool get complete => _amount > 0 && _paymentMethod != null && _accountNumber.isNotEmpty;

  Future<void> getRekenings() async {
    _homeState = HomeState.Loading;
    try{
      ApiResponse<List<PaymentMethod>> response = await DompetServices.getRekening();

      if(response.status){
        _paymentMethodList = response.data!;
        
        _homeState = HomeState.Loaded;
      }
    }catch($e){
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<ApiResponse> makeWithDraw(int jumlah,String bank,String accountNumber, String accountName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString("userId")!;
      ApiResponse response = await DompetServices.makeWithDraw(userID,jumlah,bank,accountNumber,accountName);

      return response;
    }catch($e){
      notifyListeners();
      return ApiResponse(false,message: defaultErrorText);
    }
  }
}
