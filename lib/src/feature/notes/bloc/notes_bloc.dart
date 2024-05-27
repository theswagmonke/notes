import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes/src/feature/notes/data/notes_repo.dart';
import 'package:notes/src/feature/notes/model/note.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

part 'notes_event.dart';
part 'notes_state.dart';
part 'notes_bloc.freezed.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository repository;

  NotesBloc(this.repository) : super(const NotesState.initial()) {
    on<NotesEvent>(
      (event, emitter) => event.map<Future<void>>(
        loadNotes: (event) => _loadNotes(event, emitter),
        addNote: (event) => _addNote(event, emitter),
        deleteNoteById: (event) => _deleteNoteById(event, emitter),
        editNote: (event) => _editNote(event, emitter),
      ),
      transformer: bloc_concurrency.sequential(),
    );
  }

  Future<void> _loadNotes(
      _LoadNotes event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      final notes = await repository.getNotes();
      emit(NotesState.loaded(notes));
    } on Object catch (error, stackTrace) {
      emit(const NotesState.error());
      log(error.toString());
      log(stackTrace.toString());
      rethrow;
    }
  }

  Future<void> _addNote(
      _AddNote event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      await repository.addNote(event.note);
      final updatedNotes = await updateNotes();
      log(updatedNotes.toString());
      emit(NotesState.loaded(updatedNotes));
    } on Object catch (error, stackTrace) {
      emit(const NotesState.error());
      log(error.toString());
      log(stackTrace.toString());
      rethrow;
    }
  }

  Future<void> _deleteNoteById(
      _DeleteNoteById event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      await repository.deleteNote(event.note);
      final updatedNotes = await updateNotes();
      log(updatedNotes.toString());
      emit(NotesState.loaded(updatedNotes));
    } on Object catch (error, stackTrace) {
      emit(const NotesState.error());
      log(error.toString());
      log(stackTrace.toString());
      rethrow;
    }
  }

  Future<void> _editNote(
      _EditNote event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      await repository.editNote(event.note);
      final updatedNotes = await updateNotes();
      log(updatedNotes.toString());
      emit(NotesState.loaded(updatedNotes));
    } on Object catch (error, stackTrace) {
      emit(const NotesState.error());
      log(error.toString());
      log(stackTrace.toString());
      rethrow;
    }
  }

  Future<List<Note>> updateNotes(){
    final notes = repository.getNotes();
    return notes;
  }
}
