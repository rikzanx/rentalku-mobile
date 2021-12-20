import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/models/payment_method.dart';
import 'package:rentalku/models/top_up.dart';
import 'package:rentalku/services/api_response.dart';
import 'dart:developer';
import 'package:rentalku/models/dompet.dart';

class DompetServices {
  DompetServices._();

  static Future<ApiResponse<Map<String,dynamic>>> getSaldo(int userId) async{
    final response = await http.get(
      apiURL.resolve('dompetku/$userId'),
      headers: acceptJson,
    );
    try{
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json['content']['saldo']);

        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<Map<String,dynamic>>(true, data: json['content']);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print("erik");
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

  static Future<ApiResponse<List<PaymentMethod>>> getRekening() async{
    final response = await http.get(
      apiURL.resolve('rekening'),
      headers: acceptJson,
    );
    try{
      if(response.statusCode == HttpStatus.ok){
        List<PaymentMethod> rekenings = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          rekenings.add(PaymentMethod.fromJson(e));
         });

        return ApiResponse<List<PaymentMethod>>(true, data: rekenings);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print("aaaaa");
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<TopUp>> makeTopUp(String userId, int rekeningId,int jumlah) async{
    final response = await http.post(
      apiURL.resolve('dompetku/topup'),
      headers: acceptJson,
      body: {
        'user_id' : userId.toString(),
        'rekening_id' : rekeningId.toString(),
        'jumlah' : jumlah.toString()
      }
    );
    try {
      if(response.statusCode == HttpStatus.created){
        final Map<String,dynamic> json = jsonDecode(response.body);

        return ApiResponse(true,data: TopUp.fromJson(json['content']));
      }else{
        print("else topup");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse> makeWithDraw(String userId,int jumlah,String bank,String noRek,String atasNama) async{
    final response = await http.post(
      apiURL.resolve('dompetku/penarikan'),
      headers: acceptJson,
      body: {
        'user_id' : userId.toString(),
        'jumlah' : jumlah.toString(),
        'bank' : bank,
        'no_rek' : noRek,
        'atas_nama': atasNama
      }
    );
    try {
      if(response.statusCode == HttpStatus.created){
        final Map<String,dynamic> json = jsonDecode(response.body);

        return ApiResponse(true,data:json);
      }else{
        print("else topup");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

}
