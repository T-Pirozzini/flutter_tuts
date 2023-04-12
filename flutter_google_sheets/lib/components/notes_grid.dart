import 'package:flutter/material.dart';
import 'package:flutter_google_sheets/components/textbox.dart';
import 'package:flutter_google_sheets/services/google_sheets_api.dart';

class NotesGrid extends StatelessWidget {  
  const NotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: GoogleSheetsApi.numberOfNotes,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return MyTextBox(text: GoogleSheetsApi.currentNotes[index]);
      },
    );
  }
}
