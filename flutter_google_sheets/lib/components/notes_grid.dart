import 'package:flutter/material.dart';
import 'package:flutter_google_sheets/components/textbox.dart';

class NotesGrid extends StatelessWidget {
  final String text;
  final int numberOfNotes;
  const NotesGrid({super.key, required this.text, required this.numberOfNotes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: numberOfNotes,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return MyTextBox(text: text);
      },
    );
  }
}
