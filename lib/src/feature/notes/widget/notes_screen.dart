import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:notes/src/core/utils/theme/theme_provider.dart';
import 'package:notes/src/feature/notes/bloc/notes_bloc.dart';
import 'package:notes/src/feature/notes/model/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({
    super.key,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Note>? allNotes;
  List<Note>? filteredNotes;

  showAlertDialog(BuildContext context, Note note) {
    Widget cancelButton = TextButton(
      child: const Text("Нет"),
      onPressed: () {
        context.pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Да"),
      onPressed: () {
        BlocProvider.of<NotesBloc>(context).add(NotesEvent.deleteNoteById(note));
        context.pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Внимание!"),
      content: const Text("Вы действительно хотите удалить заметку?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _filterNotes(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredNotes = allNotes;
      });
    } else {
      setState(() {
        filteredNotes = allNotes?.where((notes) => notes.title.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeProvider.of(context);
    final isDarkTheme = themeNotifier.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Switch(
            value: isDarkTheme,
            onChanged: (value) {
              themeNotifier.toggleTheme();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('noteInfoScreen');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const CircularProgressIndicator(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (list) {
                if (allNotes == null || list != allNotes) {
                  allNotes = list;
                  filteredNotes = list;
                  _searchController.clear();
                }
                return list.isNotEmpty
                    ? Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.search_rounded),
                                    contentPadding: const EdgeInsets.only(left: 25),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                  ),
                                  onChanged: (value) => _filterNotes(value),
                                ),
                              ),
                              const SizedBox(height: 16),
                              filteredNotes!.isNotEmpty
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      clipBehavior: Clip.hardEdge,
                                      itemCount: filteredNotes!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(filteredNotes![index].title),
                                          subtitle: Text(
                                            filteredNotes![index].text,
                                            maxLines: 2,
                                            style: const TextStyle(overflow: TextOverflow.ellipsis),
                                          ),
                                          contentPadding: const EdgeInsets.only(left: 16.0, right: 12.0),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              showAlertDialog(context, filteredNotes![index]);
                                            },
                                          ),
                                          onTap: () => context.pushNamed(
                                            'noteInfoScreen',
                                            extra: filteredNotes![index],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(height: 4);
                                      },
                                    )
                                  : const Text('По данному запросу заметок не найдено'),
                            ],
                          ),
                        ],
                      )
                    : const Center(child: Text('У вас нет заметок'));
              },
            );
          },
        ),
      ),
    );
  }
}
