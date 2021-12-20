import 'package:equatable/equatable.dart';
import 'package:rentalku/models/user.dart';

class Chat extends Equatable {
  final int id;
  final User pengirim;
  final User penerima;
  final List<ChatMessage> list;

  Chat({
    required this.id,
    required this.pengirim,
    required this.penerima,
    required this.list
  });

  @override
  List<Object?> get props => [id];

  factory Chat.fromJson(Map<String,dynamic> json,List<ChatMessage> list,int userId){
    return Chat(
      id: json['id'],
      pengirim: (json['user_id'] == userId)?User.fromJson(json['user']) : User.fromJson(json['user_to']),
      penerima: (json['user_id'] == userId)?User.fromJson(json['user_to']) : User.fromJson(json['user']),
      list: list
    );
  }
}

class ChatMessage extends Equatable {
  final int id;
  final bool isSender;
  final String text;
  final DateTime dateTime;

  ChatMessage({
    required this.id,
    required this.isSender,
    required this.text,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [id];

  factory ChatMessage.fromJson(Map<String,dynamic> json, int user_id){
    return ChatMessage(
      id: json['id'],
      isSender: (json['user_id'] == user_id)? true : false,
      text: json['message'],
      dateTime: DateTime.parse(json['created_at'])
    );
  }
}
