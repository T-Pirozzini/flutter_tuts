import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_sheets/components/button.dart';
import 'package:flutter_google_sheets/components/loading_circle.dart';
import 'package:flutter_google_sheets/components/notes_grid.dart';
import 'package:flutter_google_sheets/services/google_sheets_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() => setState(() {}));
    super.initState();
  }

  void _post() {
    GoogleSheetsApi.insert(_controller.text);
    _controller.clear();
    setState(() {});
  }

  // wait for the data to be fetched from google sheets
  void startLoading() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true) {
      startLoading();
    }

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
              child: GoogleSheetsApi.loading == true
                  ? const LoadingCircle()
                  : const NotesGrid()),
          Column(
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
                  const Text('@ c r e a t e d b y t r a v i s'),
                  MyButton(
                    text: 'P O S T',
                    function: _post,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
