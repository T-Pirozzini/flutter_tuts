import 'package:flutter/material.dart';
import 'package:flutter_google_sheets/components/button.dart';
import 'package:flutter_google_sheets/components/notes_grid.dart';

import '../components/textbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  void _post() {
    print(_controller.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'P O S T A N O T E',
          style: TextStyle(color: Colors.grey[600]),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Expanded(
            child: NotesGrid(
              text: _controller.text,
              numberOfNotes: 6,
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'enter...',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('@ c r e a t e d b y t r a v i s'),
                    MyButton(
                      text: 'P O S T',
                      function: _post,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
