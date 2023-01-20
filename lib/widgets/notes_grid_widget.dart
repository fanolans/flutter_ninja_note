import 'package:flutter/material.dart';
import 'package:note/widgets/note_item_widget.dart';

import '../models/note_model.dart';

class NotesGrid extends StatefulWidget {
  final List<Note> lisNote;
  final Function(String id) toggleIsPinnedFn;

  NotesGrid({this.lisNote, this.toggleIsPinnedFn});

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    List<Note> tempListNote =
        widget.lisNote.where((note) => note.isPinned).toList();
    tempListNote.addAll(
      widget.lisNote.where((note) => !note.isPinned).toList(),
    );
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: tempListNote.length,
        itemBuilder: (ctx, index) => NoteItem(
          id: tempListNote[index].id,
          note: tempListNote[index].note,
          title: tempListNote[index].title,
          isPinned: tempListNote[index].isPinned,
          toggleIsPinnedFn: widget.toggleIsPinnedFn,
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
