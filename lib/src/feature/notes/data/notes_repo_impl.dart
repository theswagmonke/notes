import 'package:notes/src/feature/notes/data/notes_db.dart';
import 'package:notes/src/feature/notes/data/notes_repo.dart';
import 'package:notes/src/feature/notes/model/note.dart';

class NotesRepoImpl implements NotesRepository{
  final NotesDatabase _database;

  NotesRepoImpl(
    this._database
  );

  @override
  Future<List<Note>> getNotes() async {
    final data = await _database.readAll();
    return data;
  }

  @override
  Future<Note> addNote(Note note) async {
    final data = await _database.create(note);
    return data;
  }

  @override
  Future<void> deleteNote(Note note) async {
    await _database.delete(note);
  }

  @override
  Future<void> editNote(Note note) async {
    await _database.update(note);
  }

  @override
  Future<Note> getNoteById(Note note) async {
    final data = await _database.read(note.id!);
    return data;
  }

}