import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:intl/intl.dart';
import 'package:messenger_app/shared/helper_functions.dart';

class Chat extends StatefulWidget {
  int chatterId;
  Chat(this.chatterId, {super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final textFieldKey = GlobalKey();

  late double textFieldHeight;

  TextEditingController messageController = TextEditingController();
  List<dynamic> messages = [];
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  late StreamBuilder<QuerySnapshot<Map<String, dynamic>>> chatStream;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    // int chatId = {_auth.currentUser!.uid, chatterId.toString()}.hashCode

    return FirebaseFirestore.instance
        .collection('chats')
        .doc('chat-12345')
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void sendMessage() {
    if (messageController.text == '') return;

    Map<String, dynamic> newMessage = {
      'content': messageController.text,
      'sender': '123',
      'timestamp': Timestamp.now()
    };

    FirebaseFirestore.instance
        .collection('chats')
        .doc('chat-12345')
        .collection('messages')
        .add(newMessage);
  }

  @override
  void initState() {
    chatStream = realTimeChatStream();

    textFieldHeight = window.physicalSize.height * 0.1;

    messageController.addListener(() {
      double currentHeight = getWidgetSize(textFieldKey).height;
      if (currentHeight != textFieldHeight) {
        setState(() {
          textFieldHeight = currentHeight;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 5),
          height: MediaQuery.of(context).size.height * 0.90 - textFieldHeight,
          child: chatStream,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            key: textFieldKey,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: messageController,
                showCursor: true,
                minLines: 1,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: 'Enter message',
                  border: getInputBorder(true, radius: 20.0),
                  focusedBorder: getInputBorder(true, radius: 20.0),
                  alignLabelWithHint: true,
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.85,
                      minHeight: MediaQuery.of(context).size.width * 0.10),
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.send,
                  color: Colors.blue,
                  size: MediaQuery.of(context).size.width * 0.08,
                ),
                onTap: () {
                  sendMessage();
                  messageController.text = '';
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> realTimeChatStream() {
    return StreamBuilder(
      stream: getChatMessages(),
      builder: (context, docSnapshot) {
        if (docSnapshot.hasError) {
          return const Text('No messages');
        }

        if (docSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        QuerySnapshot<Map<String, dynamic>> document = docSnapshot.data!;
        messages = document.docs;

        return ListView.builder(
            controller: ScrollController(keepScrollOffset: false),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            reverse: true,
            itemCount: messages.length,
            itemBuilder: ((context, index) {
              String message = messages[index]['content'];
              DateTime time = messages[index]['timestamp'].toDate();

              var alignment = Alignment.bottomLeft;
              var bubbleType = BubbleType.receiverBubble;
              if (messages[index]['sender'] != '123') {
                alignment = Alignment.bottomRight;
                bubbleType = BubbleType.sendBubble;
              }

              return ChatBubble(
                clipper: ChatBubbleClipper10(type: bubbleType),
                alignment: alignment,
                margin: const EdgeInsets.only(top: 20),
                backGroundColor: Colors.blue,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          DateFormat('hh:mm a').format(time),
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
      },
    );
  }
}
