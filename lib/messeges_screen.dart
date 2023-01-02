import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String title = 'All Messages';
  final List<String> tabs = ['All', 'Friends', 'Bots', 'Groups'];
  late int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            CurvedNavigationBar(
              backgroundColor: Colors.blueAccent,
              items: const <Widget>[
                Icon(
                  Icons.person,
                  size: 30,
                ),
                Icon(Icons.messenger, size: 30),
                Icon(Icons.computer_rounded, size: 30),
                Icon(Icons.group, size: 30),
              ],
              onTap: (index) {
                setState(() {
                  title = tabs[index];
                  currentIndex = index;
                });
              },
            ),
            ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.computer_rounded),
                    trailing: const Text(
                      "GFG",
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text("List item $index"),
                    subtitle: const Text('hellooooooooooo'),
                    onTap: () {},
                  );
                }),
          ],
        ));
  }
}
