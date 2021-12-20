import 'dart:convert';
import 'dart:io';

import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/kategori.dart';
import 'package:rentalku/models/review.dart';
import 'package:rentalku/models/ulasan_unit.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:http/http.dart' as http;

class SopirServices{
  SopirServices._();

  static Future<ApiResponse<List<User>>> getDrivers(String userId) async{
    final response = await http.get(
      apiURL.resolve("pengemudi/all/showbypemilik/$userId"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        List<User> driverList = List.empty(growable: true);
        var jsonlist = json['content']['pengemudi'] as List;
        jsonlist.forEach((element) {
           driverList.add(User.fromJson(element['user']));
        });

        return ApiResponse(true, data: driverList);
      }else{
        return ApiResponse(false,message: defaultErrorText);
      }
    }catch ($e){
      return ApiResponse(false,message: defaultErrorText);
    }

  }

  static Future<ApiResponse> registerDriver(Map<String,String> body,String foto_ktp,String foto_sim) async{
    var request = http.MultipartRequest('POST',apiURL.resolve('pengemudi/create'));
    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath('foto_ktp', foto_ktp));
    request.files.add(await http.MultipartFile.fromPath('foto_sim', foto_sim));
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    try{
      if(responseStream.statusCode == HttpStatus.created){
        // final Map<String,dynamic> json = jsonDecode(response.body);
        return ApiResponse(true,message: "berhasil didaftarakan");
      }else {
        
        print("b");
        print(response.body);
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print("dari service");
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

}