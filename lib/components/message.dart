import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  late String sender;
  late String reciever;
  late String content;
  late Timestamp time;

  Message(this.content, this.sender, this.reciever) {
    time = Timestamp.now();
  }

  Message.fromJson(data) {
    content = data['content'];
    sender = data['sender'];
    reciever = data['reciever'];

    time = Timestamp.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': sender,
      'reciever': reciever,
      'timestamp': time.toString()
    };
  }
}

class ChatMessage extends StatelessWidget {
  final Message message;
  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: const BorderRadius.all(Radius.elliptical(1, 2)),
          )),
      Container(
        decoration: BoxDecoration(),
      )
    ]);
  }
}
