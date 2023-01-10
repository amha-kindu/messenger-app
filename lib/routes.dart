import 'package:messenger_app/Friends.dart';
import 'package:messenger_app/login.dart';
import 'package:messenger_app/main.dart';
import 'package:messenger_app/signup.dart';

final Routes = {
  '/': (context) => const Friends(),
  '/signup': (context) => const SignupPage(),
  '/chat': (context) => const ChatPage(),
  '/login': (context) => const LoginPage()
};
