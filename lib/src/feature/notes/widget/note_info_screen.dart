import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/src/feature/notes/bloc/notes_bloc.dart';
import 'package:notes/src/feature/notes/model/note.dart';

class NoteInfoScreen extends StatefulWidget {
  final Note? note;

  const NoteInfoScreen({
    this.note,
    super.key,
  });

  @override
  State<NoteInfoScreen> createState() => _NoteInfoScreenState();
}

class _NoteInfoScreenState extends State<NoteInfoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  late bool isEditable;

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _textController.text = widget.note!.text;
    }
    widget.note == null ? isEditable = true : isEditable = false;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.note == null ? 'Cоздание заметки' : widget.note!.title),
        actions: [
          widget.note != null
              ? Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showAlertDialog(context, widget.note!);
                    },
                  ),
              )
              : const SizedBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isEditable) {
            if (_titleController.text.isNotEmpty && _textController.text.isNotEmpty) {
              if (widget.note == null) {
                Note note = Note(text: _textController.text, title: _titleController.text);
                BlocProvider.of<NotesBloc>(context).add(NotesEvent.addNote(note));
              } else {
                Note note = widget.note!.copyWith(text: _textController.text, title: _titleController.text);
                BlocProvider.of<NotesBloc>(context).add(NotesEvent.editNote(note));
              }
              context.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Необходимо заполнить все поля',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            setState(() {
              isEditable = true;
            });
          }
        },
        backgroundColor: widget.note == null || isEditable ? Colors.lightBlue : Colors.amber,
        child: widget.note == null || isEditable ? const Icon(Icons.check_rounded) : const Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              readOnly: isEditable ? false : true,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Заголовок',
                hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _textController,
              readOnly: isEditable ? false : true,
              style: const TextStyle(fontSize: 16),
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Текст',
                hintStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
