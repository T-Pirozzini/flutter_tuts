import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: IconButton(
            onPressed: () {
              // open drawer
            },
            icon: Icon(
              Icons.menu,
              color: Colors.grey[800],
              size: 36,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              onPressed: () {
                // open profile
              },
              icon: Icon(
                Icons.person,
                color: Colors.grey[800],
                size: 36,
              ),
            ),
          ),
        ],
      ),
      body: Column(children: [
        // I want to eat

        // tab bar

        // tab bar view
      ],)
    );
  }
}
