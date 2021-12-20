import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/payment_method.dart';
import 'package:rentalku/models/top_up.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/dompet_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopUpProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;
  TopUpProvider(){
    getRekenings();
  }

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

  Future<ApiResponse<TopUp>> makeTopUp(int rekeningId,int jumlah) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString("userId")!;
      ApiResponse<TopUp> response = await DompetServices.makeTopUp(userID,rekeningId,jumlah);

      return response;
    }catch($e){
      notifyListeners();
      return ApiResponse(false,message: defaultErrorText);
    }
  }
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

  TopUp? _topUp;
  TopUp? get topUp => _topUp;
  set topUp(TopUp? topUp){
    _topUp = topUp;
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

  bool get complete => _amount >= 10000 && _paymentMethod != null;
}
