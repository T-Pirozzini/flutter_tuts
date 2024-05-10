import 'package:flutter/material.dart';
import 'package:flutter_rpg_tut/screens/create/create.dart';
import 'package:flutter_rpg_tut/screens/home/home.dart';
import 'package:flutter_rpg_tut/theme.dart';

void main() {
  runApp(MaterialApp(
    theme: primaryTheme,
    home: const Create(),
  ));
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: const Center(
        child: Text('sandbox'),
      ),
    );
  }
}
