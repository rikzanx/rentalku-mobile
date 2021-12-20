import 'dart:convert';
import 'dart:io';

import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/review.dart';
import 'package:rentalku/models/ulasan_unit.dart';
import 'package:rentalku/providers/ulasan_unit_provider.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:http/http.dart' as http;

class UlasanServices{
  UlasanServices._();

  static Future<ApiResponse<UlasanUnit>> getUlasanUnit(int kendaraanId) async{
    String kendaraan = kendaraanId.toString();
    final response = await http.get(
      apiURL.resolve("rating/kendaraan/all/${kendaraanId}"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json);
        List<Rating> ratingList = List.empty(growable: true);
        var jsonlist = json['content']['rating_kendaraan'] as List;
        print(jsonlist);
        jsonlist.forEach((element) { 
          ratingList.add(Rating.fromJson(element));
        });
        UlasanUnit ulasanUnit = UlasanUnit.fromJson(json['content'],ratingList);
        return ApiResponse<UlasanUnit>(true, data: ulasanUnit);
      }else{
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<UlasanUnit>> getUlasanPemilik(int kendaraanId) async{
    String kendaraan = kendaraanId.toString();
    final response = await http.get(
      apiURL.resolve("rating/user/all/${kendaraanId}"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json);
        List<Rating> ratingList = List.empty(growable: true);
        var jsonlist = json['content']['rating_user'] as List;
        print(jsonlist);
        jsonlist.forEach((element) { 
          ratingList.add(Rating.fromJson(element));
        });
        UlasanUnit ulasanUnit = UlasanUnit.fromJson(json['content'],ratingList);
        return ApiResponse<UlasanUnit>(true, data: ulasanUnit);
      }else{
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<UlasanUnit>> getUlasanPemilikByUserId(String userId) async{
    final response = await http.get(
      apiURL.resolve("rating/user/all/byuser/${userId}"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        print("oke");
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json);
        List<Rating> ratingList = List.empty(growable: true);
        var jsonlist = json['content']['rating_user'] as List;
        print(jsonlist);
        jsonlist.forEach((element) { 
          ratingList.add(Rating.fromJson(element));
        });
        UlasanUnit ulasanUnit = UlasanUnit.fromJson(json['content'],ratingList);
        return ApiResponse<UlasanUnit>(true, data: ulasanUnit);
      }else{
        print("else");
        print(response.body);
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<bool> makeReview(Map<String,String> body) async {
    final response = await http.post(
      apiURL.resolve('transaksi/create/rating'),
      headers: acceptJson,
      body: body,
    );
    try{
      if(response.statusCode == HttpStatus.created){
        final Map<String, dynamic> json = jsonDecode(response.body);

        return true;
      }else{
        return false;
      }
    }catch($e){
      print($e);
      return false;
    }
  }

}