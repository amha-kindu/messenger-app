import 'package:flutter/material.dart';
import 'package:messenger_app/main.dart';

class Friends extends StatelessWidget {
  const Friends({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: Container(
          color: Colors.amberAccent,
          width: constraints.maxWidth * 0.8,
          height: constraints.maxHeight * .8,
          child: TextButton(
            onPressed: (() {
              MyApp.authetication.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            }),
            child: const Text('logout'),
          ),
        ),
      );
    });
  }
}
// I have worked with restful api services using springboot for over a year and thus I have a lot of experience with back-end development and restful api services and I am also excellent with javascript and node.js I am currently working on a project using node.js using express.js therefore I would be perfect for this role. If you give me the opportunity to be part of your internship program I would do my best at accomplishing all the tasks assigned with me.