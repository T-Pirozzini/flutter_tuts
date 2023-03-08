import 'package:flutter/material.dart';
import 'package:flutter_notes/data/hive_database.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  // hive database
  final db = HiveDatabase();

  // overall list of notes
  List<Note> allNotes = [];

  // initialize list
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  // get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  // add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  // update note
  void updateNote(Note note, String text) {
    // go through list of all notes
    for (int i = 0; i < allNotes.length; i++) {
      // find the relevent note
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  // delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
