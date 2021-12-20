import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/commons/helpers.dart';
import 'package:rentalku/models/user.dart';
import 'package:rentalku/pages/profile/update_password_page.dart';
import 'package:rentalku/services/api_response.dart';

class UserServices {
  UserServices._();

  static Future<ApiResponse<User>> changeImage(Map<String,String> body, String filePath) async {
    var request = http.MultipartRequest('POST',apiURL.resolve('user/edit'));
    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath('image', filePath));
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    try{
      if(responseStream.statusCode == HttpStatus.created){
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<User>(true, data: User.fromJson(json['content']));
      }else {
        print("else");
        print("user edit user");
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      print($e);
      print("user edit user");
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<User>> changeUser(String userId, String nama, String alamat, String tanggal_lahir, String telp) async{
    final response = await http.post(
      apiURL.resolve('user/edit'),
      headers: acceptJson,
      body: { 
        'user_id':userId, 
        'name': nama, 
        'alamat': alamat, 
        'tanggal_lahir' : tanggal_lahir, 
        'telp': telp },
    );
    try{
      if(response.statusCode == HttpStatus.created){
        final Map<String, dynamic> json = jsonDecode(response.body);

        return ApiResponse<User>(true, data: User.fromJson(json['content']));
      }else{
        print("else");
        return ApiResponse(false, message: "Gagal Edit Profil");
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<User>> changeLocation(String userId, String kota) async{
    final response = await http.post(
      apiURL.resolve('update/kota'),
      headers: acceptJson,
      body: { 
        'user_id':userId, 
        'kota': kota },
    );
    try{
      print(response.statusCode);
      if(response.statusCode == HttpStatus.created){
        final Map<String, dynamic> json = jsonDecode(response.body);

        return ApiResponse<User>(true, data: User.fromJson(json['content']));
      }else{
        print("else");
        print(response.body);
        return ApiResponse(false, message: "Gagal Edit Profil");
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<User>> changePassword(String userId, String password, String passwordNew) async{
    final response = await http.post(
      apiURL.resolve('user/edit'),
      headers: acceptJson,
      body: { 'user_id':userId, 'password': password, 'new_password' : passwordNew },
    );
    try{
      if(response.statusCode == HttpStatus.created){
        final Map<String, dynamic> json = jsonDecode(response.body);

        return ApiResponse<User>(true, data: User.fromJson(json['content']));
      }else{
        print("else");
        return ApiResponse(false, message: "Gagal Ganti Katasandi");
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<User>> registerOwner(Map<String,String> body, String filePath) async {
    var request = http.MultipartRequest('POST',apiURL.resolve('register/pemilik'));
    request.fields.addAll(body);
    request.files.add(await http.MultipartFile.fromPath('foto_ktp', filePath));
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    try{
      if(responseStream.statusCode == HttpStatus.created){
        // print("a");
        final Map<String,dynamic> json = jsonDecode(response.body);
        // print(json['content']['saldo']);
        // String saldo = json['content']['saldo'] as String;
        return ApiResponse<User>(true, data: User.fromJson(json['content']));
      }else {
        // print("b");
        print(response.body);
        return ApiResponse(false, message: defaultErrorText);
      }

    }catch($e){
      // print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }
}