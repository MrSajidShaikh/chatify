
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? sender, receiver, message,image;
  Timestamp time;

  ChatModel(
      {required this.sender,
        required this.receiver,
        required this.message,
        required this.image,
        required this.time

      });

  factory ChatModel.fromMap(Map m1) {
    return ChatModel(
      sender: m1['sender'],
      receiver: m1['receiver'],
      message: m1['message'],
      time: m1['time'],
      image: m1['image'],
    );
  }

  Map<String, dynamic> toMap(ChatModel chat) {
    return {
      'sender': chat.sender,
      'receiver': chat.receiver,
      'message': chat.message,
      'image':chat.image,
      'time':chat.time,
    };
  }
}
