import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:intl/intl.dart';
import 'package:messenger_app/main.dart';
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
  final FocusNode messageFocusNode = FocusNode();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  late StreamBuilder<QuerySnapshot<Map<String, dynamic>>> chatStreamBuilder;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    // int chatId = {_auth.currentUser!.uid, chatterId.toString()}.hashCode

    return MyApp.dataStorage
        .collection('chats')
        .doc('chat-12345')
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  void sendMessage() {
    if (messageController.text == '') return;

    Map<String, dynamic> newMessage = {
      'content': messageController.text,
      'sender': '123',
      'timestamp': Timestamp.now()
    };

    MyApp.dataStorage
        .collection('chats')
        .doc('chat-12345')
        .collection('messages')
        .add(newMessage);
  }

  @override
  void initState() {
    chatStreamBuilder = realTimeChatStreamBuilder();

    double pixelRatio = window.devicePixelRatio;
    textFieldHeight = (window.physicalSize.width / pixelRatio) * 0.1;

    messageController.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90 - textFieldHeight,
          child: chatStreamBuilder,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ListTile(
            title: KeyboardListener(
              focusNode: messageFocusNode,
              onKeyEvent: ((value) {
                double currentHeight = getWidgetSize(textFieldKey).height;
                if (currentHeight != textFieldHeight) {
                  setState(() {
                    textFieldHeight = currentHeight;
                  });
                }
              }),
              child: TextField(
                key: textFieldKey,
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
                      maxWidth: MediaQuery.of(context).size.width * 0.90,
                      minHeight: MediaQuery.of(context).size.width * 0.10),
                ),
              ),
            ),
            trailing: GestureDetector(
              child: const Icon(
                Icons.send,
                color: Colors.blue,
                size: 45,
              ),
              onTap: () {
                sendMessage();
                messageController.text = '';
              },
            ),
          ),
        )
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
      realTimeChatStreamBuilder() {
    List<dynamic> messages = [];

    return StreamBuilder(
      stream: getChatMessages(),
      builder: (context, querySnapshot) {
        if (querySnapshot.hasError) {
          return const Center(child: Text('No messages to show'));
        }

        if (querySnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        messages = querySnapshot.data!.docs;

        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            reverse: true,
            itemCount: messages.length,
            itemBuilder: ((context, index) {
              String message = messages[index]['content'];
              DateTime time = messages[index]['timestamp'].toDate();
              DateTime? prevTime;
              if (index != messages.length - 1) {
                prevTime = messages[index + 1]['timestamp'].toDate();
              }

              var alignment = Alignment.bottomLeft;
              var bubbleType = BubbleType.receiverBubble;
              if (messages[index]['sender'] != '123') {
                alignment = Alignment.bottomRight;
                bubbleType = BubbleType.sendBubble;
              }

              bool showMonthYear = false;
              String? monthYear;
              if (prevTime != null) {
                showMonthYear = (time.year > prevTime.year ||
                    time.month > prevTime.month ||
                    time.day > prevTime.day);

                List<String> dayMonthYear =
                    DateFormat.yMMMEd().format(time).split(',');

                if (time.year == DateTime.now().year) {
                  dayMonthYear.removeLast();
                } else {
                  dayMonthYear.removeAt(0);
                }
                monthYear = dayMonthYear.join(',');
              }

              return Column(
                children: [
                  if (showMonthYear)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Center(
                        child: Text(monthYear!),
                      ),
                    ),
                  ChatBubble(
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
                  ),
                ],
              );
            }));
      },
    );
  }
}
