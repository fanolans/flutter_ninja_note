import 'package:flutter/material.dart';
import 'package:note/models/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  final Function(Note note) addNoteFn;

  const AddNoteScreen({this.addNoteFn});
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Note _note = Note(
    id: null,
    title: '',
    note: '',
    updatedAt: null,
    createdAt: null,
  );
  final _formKey = GlobalKey<FormState>();

  void submitNote() {
    _formKey.currentState.save();
    final now = DateTime.now();
    _note = _note.copyWith(
      createdAt: now,
      updatedAt: now,
    );
    widget.addNoteFn(_note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: submitNote,
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Judul',
                  border: InputBorder.none,
                ),
                onSaved: (newValue) {
                  _note = _note.copyWith(title: newValue);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Tulis catatan disini...',
                  border: InputBorder.none,
                ),
                onSaved: (newValue) {
                  _note = _note.copyWith(note: newValue);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
