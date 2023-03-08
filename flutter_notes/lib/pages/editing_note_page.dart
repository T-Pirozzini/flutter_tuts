import 'package:flutter/material.dart';
import 'package:flutter_notes/models/note.dart';
import 'package:flutter_quill/flutter_quill.dart';

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
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  // load existing note
  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // add new note
  void addNewNote(int i) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
