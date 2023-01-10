import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger_app/components/chat.dart';
import 'package:messenger_app/routes.dart';
import 'package:messenger_app/shared/helper_functions.dart';
import 'firebase_options.dart';

late final FirebaseApp myMessagerApp;

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => myMessagerApp = value);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseFirestore dataStorage = FirebaseFirestore.instance;

  static FirebaseAuth authetication = FirebaseAuth.instance;
  static bool signedIn = false;

  const MyApp({super.key});

  initialize() {
    dataStorage
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
    // dataStorage.settings = const Settings(
    //   persistenceEnabled: true,
    //   cacheSizeBytes: 200,

    // );

    authetication.userChanges().listen(userChangeListener);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initialize();

    String initialRoute = authetication.currentUser != null ? '/' : '/login';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      initialRoute: initialRoute,
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
