import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/models/slider_image.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/services/api_response.dart';
import 'dart:developer';
import 'package:rentalku/models/dompet.dart';

class SeacrhServices {
  SeacrhServices._();

  static Future<ApiResponse<List<Unit>>> getUnits(String query, List<String> category,String kota) async{
    String namaParameter = "&kategori[]=";
    String kategoriQuery = "";
    category.forEach((element) {
      kategoriQuery += namaParameter+element.toString();
     });
    final response = await http.get(
      apiURL.resolve("search?q=${query}${kategoriQuery}&kota=${kota}"),
      headers: acceptJson,
    );
    print(query);
    try{
      if(response.statusCode == HttpStatus.ok){
        List<Unit> units = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          units.add(Unit.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;

        return ApiResponse<List<Unit>>(true, data: units);
      }else {

        print("elseku");
        print(response.body);
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Unit>>> getMyUnits(String userId) async{
    final response = await http.get(
      apiURL.resolve("kendaraan/owner/${userId}"),
      headers: acceptJson,
    );
    try{
      if(response.statusCode == HttpStatus.ok){
        List<Unit> units = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          units.add(Unit.fromJson(e));
         });

        return ApiResponse<List<Unit>>(true, data: units);
      }else {
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<SliderImage>>> getSliderImages() async{
    final response = await http.get(
      apiURL.resolve('slider'),
      headers: acceptJson,
    );
    try{
      if(response.statusCode == HttpStatus.ok){
        List<SliderImage> sliderImages = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          sliderImages.add(SliderImage.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;

        return ApiResponse<List<SliderImage>>(true, data: sliderImages);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<String>>> getKategori() async{
    final response = await http.get(
      apiURL.resolve('kategori'),
      headers: acceptJson,
    );
    try{
      if(response.statusCode == HttpStatus.ok){
        List<String> kategori = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          kategori.add(e['name']);
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<List<String>>(true, data: kategori);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

}
