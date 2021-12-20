import 'dart:convert';
import 'dart:io';

import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/chat.dart';
import 'package:rentalku/models/kategori.dart';
import 'package:rentalku/models/ulasan_unit.dart';
import 'package:rentalku/models/unit.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:http/http.dart' as http;

class ChatServices{
  ChatServices._();

  static Future<ApiResponse<List<Chat>>> getChatList(String userId) async{
    final response = await http.get(
      apiURL.resolve("message/room/$userId"),
      headers: acceptJson
    );
    try {
      if(response.statusCode == HttpStatus.ok){
        final List<dynamic> json = jsonDecode(response.body);
        // print(json);
        List<Chat> chatList = List.empty(growable: true);
        // var jsonlist = json as List;
        int userIdint = int.parse(userId);
        // print(jsonlist.runtimeType);
        json.forEach((element){ 
          // print(element.runtimeType);
          // Map<String,dynamic> elem = element;
          List<ChatMessage> messageList = List.empty(growable: true);
          var jsonlist2 = element['message'] as List;
          // print(jsonlist2.runtimeType);
          jsonlist2.forEach((element2) {
            // print(element2.runtimeType);
            messageList.add(ChatMessage.fromJson(element2, userIdint));
          });
          chatList.add(Chat.fromJson(element, messageList, userIdint));
        });

        return ApiResponse(true, data: chatList);
      }else{
        return ApiResponse(false, message: defaultErrorText);
      }
    }catch($e){
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
  }

  static Future<ApiResponse<ChatMessage>> sendMessage(String userId,String chatRoomId, String message) async{
    final response = await http.post(
      apiURL.resolve('message/send'),
      headers: acceptJson,
      body: { 
        'user_id':userId, 
        'chat_room_id': chatRoomId, 
        'message': message,
        },
    );

    try {
      if(response.statusCode == HttpStatus.created){
        final Map<String,dynamic> json = jsonDecode(response.body);
        int userIdInt = int.parse(userId);
        print(json);
        print("oke bkbkj");
        return ApiResponse<ChatMessage>(true, data: ChatMessage.fromJson(json, userIdInt));
      }else{
        print(response.body);
        print('else');
        return ApiResponse(false, message: defaultErrorText);
      }
    } catch ($e) {
      print($e);
      return ApiResponse(false, message: defaultErrorText);
    }
    
  }

}