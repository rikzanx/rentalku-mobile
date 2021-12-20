import 'dart:convert';
import 'dart:io';

import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/kategori.dart';
import 'package:rentalku/models/lokasi.dart';
import 'package:rentalku/models/ulasan_unit.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/pages/chats/view_chat_page.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:http/http.dart' as http;

class UnitServices{
  UnitServices._();

  static Future<ApiResponse<UlasanUnit>> getUlasanUnit(int kendaraanId) async{
    String kendaraan = kendaraanId.toString();
    final response = await http.get(
      apiURL.resolve("rating/kendaraan/all/$kendaraan"),
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
        // print(response.body);
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Kategori>>> getKategoriList() async{
    final response = await http.get(
      apiURL.resolve("kategori"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json);
        List<Kategori> kategoriList = List.empty(growable: true);
        var jsonlist = json['content'] as List;
        print(jsonlist);
        jsonlist.forEach((element) { 
          kategoriList.add(Kategori.fromJson(element));
        });
        return ApiResponse<List<Kategori>>(true, data: kategoriList);
      }else{
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<Unit>> registerUnit(Map<String,String> body,String filePath) async{
    var request = http.MultipartRequest('POST',apiURL.resolve('kendaraan/store'));
    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath('image_link', filePath));
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    try{
      if(responseStream.statusCode == HttpStatus.created){
        final Map<String,dynamic> json = jsonDecode(response.body);
        return ApiResponse<Unit>(true, data: Unit.fromJson(json['content']));
      }else {
        print("b");
        // print(response.body);
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print("dari service");
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<Unit>> changeUnit(int unitId,Map<String,String> body,bool withImage,{String filePath =""}) async{
    String unitId2 = unitId.toString();
    var request = http.MultipartRequest('POST',apiURL.resolve("kendaraan/update/$unitId2"));
    request.fields.addAll(body);
    if(withImage){
      request.files.add(await http.MultipartFile.fromPath('image_link', filePath));
    }
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    try{
      if(responseStream.statusCode == HttpStatus.created){
        final Map<String,dynamic> json = jsonDecode(response.body);
        return ApiResponse<Unit>(true, data: Unit.fromJson(json['content']));
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

  static Future<ApiResponse<Lokasi>> getUnitLocation(int unitId) async{
    String unitID = unitId.toString();
    final response = await http.get(
      apiURL.resolve("maps/track/$unitID"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        Lokasi location= Lokasi.fromJson(json);
        return ApiResponse<Lokasi>(true,data: location);
      }else{
        return ApiResponse(false,message:defaultErrorText);
      }
    } catch (e) {
      return ApiResponse(false,message:defaultErrorText);
    }
  }
  
}