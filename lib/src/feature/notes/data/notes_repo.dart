import 'package:notes/src/feature/notes/model/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<Note> getNoteById(Note note);
  Future<Note> addNote(Note note);
  Future<void> deleteNote(Note note);
  Future<void> editNote(Note note);
}