import 'package:flutter/material.dart';
import 'package:my_notes/core/view_model/note.dart';
import '../services/note_service.dart';

class NoteViewModel extends ChangeNotifier {
  final NoteService _noteService = NoteService();

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDarkMode = false; 
  bool get isDarkMode => _isDarkMode; 

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Fetch notes and show loading indicator while fetching
  Future<void> fetchNotes() async {
    setLoading(true);
    _notes = await _noteService.getNotes();
    setLoading(false);
  }

  // Add note and refresh the note list
  Future<void> addNote(String title, String content) async {
    setLoading(true);
    await _noteService.addNote(Note(
      title: title,
      content: content,
    ));
    await fetchNotes();
    setLoading(false);
  }

  // Update note and refresh the note list
  Future<void> updateNote(Note note) async {
    setLoading(true);
    await _noteService.updateNote(note);
    await fetchNotes();
    setLoading(false);
  }

  // Delete note by id and refresh the note list
  Future<void> deleteNoteById(int id) async {
    setLoading(true);
    await _noteService.deleteNoteById(id);
    await fetchNotes();
    setLoading(false);
  }

  // Wrapper method to delete a note by calling the method in the service
  Future<void> deleteNote(int id) async {
    await deleteNoteById(id);
  }

  // Method to toggle theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode; 
    notifyListeners(); 
  }
}
