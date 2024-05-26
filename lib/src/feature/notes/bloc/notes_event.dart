part of 'notes_bloc.dart';

@freezed
class NotesEvent with _$NotesEvent {
  const factory NotesEvent.loadNotes() = _LoadNotes;
  const factory NotesEvent.addNote(Note note) = _AddNote;
  const factory NotesEvent.deleteNoteById(Note note) = _DeleteNoteById;
  const factory NotesEvent.editNote(Note note) = _EditNote;
}
