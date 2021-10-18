import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rentalku/models/chat.dart';

class ChatProvider extends ChangeNotifier {
  List<Chat> _chats = List.generate(
    4,
    (index) => Chat(
      id: 1,
      name: "Asep",
      role: "Sopir",
      imageURL: "https://lorempixel.com/200/200/people/",
      list: List.generate(
        Random().nextInt(5) + 5,
        (index) => ChatMessage(
          id: 1,
          isSender: Random().nextBool(),
          text: "Selamat siang... apakah untuk tanggal 13 oktober tersedia...",
          dateTime: DateTime.now(),
        ),
      ),
    ),
  );
  List<Chat> get chats => _chats;
  set chats(List<Chat> chats){
    _chats = chats;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int selectedIndex){
    _selectedIndex = selectedIndex;
    notifyListeners();
  }
}
