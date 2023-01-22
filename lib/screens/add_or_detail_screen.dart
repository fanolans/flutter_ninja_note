import 'package:flutter/material.dart';
import 'package:note/models/note_model.dart';
import 'package:note/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class AddOrDetailScreen extends StatefulWidget {
  static const routeName = '/AddOrDetailScreen';
  @override
  _AddOrDetailScreenState createState() => _AddOrDetailScreenState();
}

class _AddOrDetailScreenState extends State<AddOrDetailScreen> {
  Note _note = Note(
    id: null,
    title: '',
    note: '',
    updatedAt: null,
    createdAt: null,
  );
  bool init = true;
  final _formKey = GlobalKey<FormState>();

  void submitNote() {
    _formKey.currentState.save();
    final now = DateTime.now();
    _note = _note.copyWith(
      createdAt: now,
      updatedAt: now,
    );
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    notesProvider.addNote(_note);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      String id = ModalRoute.of(context).settings.arguments as String;
      _note = Provider.of<NotesProvider>(context).getNote(id);
      init = false;
    }

    super.didChangeDependencies();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _note.title,
                  decoration: const InputDecoration(
                    hintText: 'Judul',
                    border: InputBorder.none,
                  ),
                  onSaved: (newValue) {
                    _note = _note.copyWith(title: newValue);
                  },
                ),
                TextFormField(
                  initialValue: _note.note,
                  decoration: const InputDecoration(
                    hintText: 'Tulis catatan disini...',
                    border: InputBorder.none,
                  ),
                  onSaved: (newValue) {
                    _note = _note.copyWith(note: newValue);
                  },
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}