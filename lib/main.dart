import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger_app/components/chat.dart';
import 'package:messenger_app/routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseFirestore dataStorage = FirebaseFirestore.instance;

  const MyApp({super.key});

  initialize() {
    dataStorage
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));

    // dataStorage.settings = const Settings(
    //   persistenceEnabled: true,
    //   cacheSizeBytes: 200,

    // );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: Routes,
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Chat(123),
    );
  }
}
