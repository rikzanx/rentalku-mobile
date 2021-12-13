import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/services/api_response.dart';
import 'dart:developer';
import 'package:rentalku/models/dompet.dart';

class DompetServices {
  DompetServices._();

  static Future<ApiResponse<int>> getSaldo(int userId) async{
    final response = await http.get(
      apiURL.resolve('dompetku/$userId'),
      headers: acceptJson,
    );
    try{
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        print(json['content']['saldo']);
        if(json['content']['saldo'] is int){
          print("ini int");
        }
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<int>(true, data: json['content']['saldo']);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<Dompet>> getDompet(int userId) async {
    final response = await http.get(
      apiURL.resolve('dompetku/$userId'),
      headers: acceptJson,
    );

    try {
      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print("sukses");
        print(json.toString());
        return ApiResponse<Dompet>(true, data: Dompet.fromJson(json['content']));
      } else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }
    } catch ($e) {
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

}
