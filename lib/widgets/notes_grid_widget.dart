import 'package:flutter/material.dart';
import 'package:note/providers/notes_provider.dart';
import 'package:note/widgets/note_item_widget.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';

class NotesGrid extends StatefulWidget {
  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    List<Note> listNote = notesProvider.notes;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: listNote.length,
        itemBuilder: (ctx, index) => NoteItem(
          id: listNote[index].id,
          ctx: context,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
      ),
    );
  }
}
