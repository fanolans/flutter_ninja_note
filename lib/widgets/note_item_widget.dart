import 'package:flutter/material.dart';
import 'package:note/presentations/custom_icons_icons.dart';
import 'package:note/providers/notes_provider.dart';
import 'package:note/screens/add_or_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';

class NoteItem extends StatefulWidget {
  // const NoteItem({Key key}) : super(key: key);
  final String id;

  const NoteItem({
    @required this.id,
  });
  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    Note note = notesProvider.getNote(widget.id);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AddOrDetailScreen.routeName,
        arguments: note.id,
      ),
      child: GridTile(
        header: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              notesProvider.toggleIsPinned(note.id);
            },
            icon: Icon(
              note.isPinned ? CustomIcons.pin : CustomIcons.pin_outline,
            ),
          ),
        ),
        footer: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(note.title),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[800],
          ),
          padding: const EdgeInsets.all(12),
          child: Text(note.note),
        ),
      ),
    );
  }
}
