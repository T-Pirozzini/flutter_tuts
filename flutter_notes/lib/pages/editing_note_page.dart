import 'package:flutter/material.dart';
import 'package:flutter_notes/models/note.dart';

class EditingNotePage extends StatefulWidget {
  EditingNotePage({
    super.key,
    required this.note,
    required this.isNewNote,
  });
  Note note;
  bool isNewNote;

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
