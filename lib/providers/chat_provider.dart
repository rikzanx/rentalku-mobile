import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rentalku/commons/constants.dart';
import 'package:rentalku/models/chat.dart';
import 'package:rentalku/services/api_response.dart';
import 'package:rentalku/services/chat_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  HomeState get homeState => _homeState;
  List<Chat> _chats =[];
  List<Chat> get chats => _chats;
  set chats(List<Chat> chats) {
    _chats = chats;
    notifyListeners();
  }
  void addChat(int index,ChatMessage message){
    _chats[index].list.add(message);
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  Future getChats() async{
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString("userId")!;
      ApiResponse response = await ChatServices.getChatList(userID);
      if(response.status){
        _chats = response.data!;
        _homeState = HomeState.Loaded;
      }else{
        _homeState = HomeState.Error;
      }
    } catch ($e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<bool> sendChat(String chatRoomId, String message) async{
    _homeState = HomeState.Loading;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userID = prefs.getString("userId")!;
      ApiResponse response = await ChatServices.sendMessage(userID, chatRoomId, message);
      if(response.status){
        print("oke iniii");
        // this.addChat(selectedIndex,response.data!);
        this.getChats();
        _homeState = HomeState.Loaded;
        notifyListeners();
        return true;
      }else{
        print("errorrr");
        _homeState = HomeState.Error;
        notifyListeners();
        return false;
      }
    } catch ($e) {
      print($e);
      _homeState = HomeState.Error;
      notifyListeners();
      return false;
    }
    
  }
}
