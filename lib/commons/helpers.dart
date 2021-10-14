import 'package:intl/intl.dart';

class Helper{
  static final _formatCurrency = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
    decimalDigits: 0,
  );

  static String toIDR(int money){
    return _formatCurrency.format(money);
  }
}