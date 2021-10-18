import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final int id;
  final String name;
  final String role;
  final String imageURL;
  final List<ChatMessage> list;

  Chat({
    required this.id,
    required this.name,
    required this.role,
    required this.imageURL,
    required this.list,
  });

  @override
  List<Object?> get props => [id];
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
}
