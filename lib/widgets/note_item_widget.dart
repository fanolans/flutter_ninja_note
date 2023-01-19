import 'package:flutter/material.dart';
import 'package:note/presentations/custom_icons_icons.dart';

class NoteItem extends StatefulWidget {
  // const NoteItem({Key key}) : super(key: key);
  final String title;
  final String note;
  final bool isPinned;
  const NoteItem({
    @required this.note,
    @required this.title,
    @required this.isPinned,
  });
  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool _isPinned;

  @override
  void initState() {
    _isPinned = widget.isPinned;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            setState(() {
              _isPinned = !_isPinned;
            });
          },
          icon: Icon(
            _isPinned ? CustomIcons.pin : CustomIcons.pin_outline,
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
          title: Text(widget.title),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[800],
        ),
        padding: const EdgeInsets.all(15),
        child: Text(widget.note),
      ),
    );
  }
}
