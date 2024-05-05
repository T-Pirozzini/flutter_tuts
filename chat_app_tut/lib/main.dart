import 'package:chat_app_tut/Auth/login_or_register.dart';
import 'package:chat_app_tut/pages/login_page.dart';
import 'package:chat_app_tut/pages/register_page.dart';
import 'package:chat_app_tut/themes/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const LoginOrRegister(),
      theme: lightMode,
    );
  }
}
