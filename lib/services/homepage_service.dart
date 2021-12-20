import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/models/booking.dart';
import 'package:rentalku/models/slider_image.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/services/api_response.dart';
import 'dart:developer';
import 'package:rentalku/models/dompet.dart';

class HomepageServices {
  HomepageServices._();

  static Future<ApiResponse<List<Unit>>> getMostUnits() async{
    final response = await http.get(
      apiURL.resolve('kendaraan/most'),
      headers: acceptJson,
    );
    try{
      if(response.statusCode == HttpStatus.ok){
        List<Unit> mostUnits = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          mostUnits.add(Unit.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;

        return ApiResponse<List<Unit>>(true, data: mostUnits);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Booking>>> getMyBookings(String userId) async{
    try{
      final response = await http.get(
        apiURL.resolve("transaksi/show/${userId}"),
        headers: acceptJson,
      );
      if(response.statusCode == HttpStatus.ok){
        List<Booking> myBookings = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          myBookings.add(Booking.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<List<Booking>>(true, data: myBookings);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Booking>>> getMyBookingsDone(String userId) async{
    try{
      final response = await http.get(
        apiURL.resolve("transaksi/show/selesai/${userId}"),
        headers: acceptJson,
      );
      if(response.statusCode == HttpStatus.ok){
        List<Booking> myBookings = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          myBookings.add(Booking.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<List<Booking>>(true, data: myBookings);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Booking>>> getPemilikBookings(String userId) async{
    try{
      final response = await http.get(
        apiURL.resolve("transaksi/show/byowner/${userId}"),
        headers: acceptJson,
      );
      if(response.statusCode == HttpStatus.ok){
        List<Booking> myBookings = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          myBookings.add(Booking.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<List<Booking>>(true, data: myBookings);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Booking>>> getPemilikBookingsDone(String userId) async{
    try{
      final response = await http.get(
        apiURL.resolve("transaksi/show/byowner/selesai/${userId}"),
        headers: acceptJson,
      );
      if(response.statusCode == HttpStatus.ok){
        List<Booking> myBookings = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          myBookings.add(Booking.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<List<Booking>>(true, data: myBookings);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Booking>>> getDriverBookings(String userId) async{
    try{
      final response = await http.get(
        apiURL.resolve("transaksi/show/bypengemudi/${userId}"),
        headers: acceptJson,
      );
      if(response.statusCode == HttpStatus.ok){
        List<Booking> myBookings = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          myBookings.add(Booking.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<List<Booking>>(true, data: myBookings);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<List<Booking>>> getDriverBookingsDone(String userId) async{
    try{
      final response = await http.get(
        apiURL.resolve("transaksi/show/bypengemudi/selesai/${userId}"),
        headers: acceptJson,
      );
      if(response.statusCode == HttpStatus.ok){
        List<Booking> myBookings = new List.empty(growable: true);
        final Map<String,dynamic> json = jsonDecode(response.body);
        var jsonlist = json['content'] as List;
        jsonlist.forEach((e) {
          myBookings.add(Booking.fromJson(e));
         });
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<List<Booking>>(true, data: myBookings);
      }else {
        print("else");
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      print("k");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<User>> getPengemudi(String transaksiId) async{
    try{
      final response = await http.get(
        apiURL.resolve("pengemudi/show/${transaksiId}"),
        headers: acceptJson,
      );
      if(response.statusCode == HttpStatus.ok){
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<User>(true, data: User.fromJson(json['content']['pengemudi']['user']));
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

}
