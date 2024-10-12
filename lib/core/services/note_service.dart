import '../db/db_helper.dart';
import '../view_model/note.dart';

class NoteService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Note>> getNotes() async {
    return await _dbHelper.fetchNotesFromDb();
  }

  Future<void> addNote(Note note) async {
    await _dbHelper.addNoteToDb(note);
  }

  Future<void> deleteNoteById(int id) async {
    await _dbHelper.deleteNoteFromDb(id);
  }

  Future<void> updateNote(Note note) async {
    await _dbHelper.updateNoteInDb(note);
  }
}
