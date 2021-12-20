import 'dart:convert';
import 'dart:io';

import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/review.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/models/unit_detail.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:http/http.dart' as http;

class OrderServices{
  OrderServices._();

  static Future<ApiResponse<UnitDetail>> getUnitDetail(int kendaraanId) async{
    String kendaraan = kendaraanId.toString();
    final response = await http.get(
      apiURL.resolve("form/transaksi/${kendaraanId}"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json);
        List<Pengemudi> pengemudiList = List.empty(growable: true);
        var jsonlist = json['content']['user']['pengemudi'] as List;
        print(jsonlist);
        jsonlist.forEach((element) { 
          pengemudiList.add(Pengemudi.fromJson(element));
        });
        Pemilik pengemudi = Pemilik.fromJson(json['content']['user'],pengemudiList);
        UnitDetail ulasanUnit = UnitDetail.fromJson(json['content'],pengemudi);
        return ApiResponse<UnitDetail>(true, data: ulasanUnit);
      }else{
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<bool> makeOrder(Map<String,String> body, String filePath) async {
    // print(filePath);
    var request = http.MultipartRequest('POST',apiURL.resolve('transaksi/create'));
    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath('foto_ktp', filePath));
    print(request.files);
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    try{
      if(responseStream.statusCode == HttpStatus.created){
        return true;
      }else {
        print(response.body);
        return false;
      }
    }catch($e){
      print($e);
      return false;
    }
  }
}