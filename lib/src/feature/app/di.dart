import 'package:get_it/get_it.dart';

import 'package:notes/src/feature/notes/bloc/notes_bloc.dart';
import 'package:notes/src/feature/notes/data/notes_repo.dart';
import 'package:notes/src/feature/notes/data/notes_repo_impl.dart';
import 'package:notes/src/feature/notes/data/notes_db.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  NotesDatabase database = NotesDatabase.instance;

  sl.registerSingleton<NotesDatabase>(database);
  sl.registerSingleton<NotesRepository>(NotesRepoImpl(sl()));

  sl.registerFactory<NotesBloc>(() => NotesBloc(sl()));
}