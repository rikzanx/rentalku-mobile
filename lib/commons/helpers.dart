import 'dart:io';

import 'package:intl/intl.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  Helper._();

  static final _formatCurrency = new NumberFormat.currency(
    locale: "id_ID",
    symbol: "Rp. ",
    decimalDigits: 0,
  );

  static String toIDR(int money) {
    return _formatCurrency.format(money);
  }

  static Future<Map<String, String>> headerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    return {
      ...acceptJson,
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
  }
}
