import 'package:flutter/material.dart';
import 'package:note/widgets/note_item_widget.dart';

import '../models/note_model.dart';

class NotesGrid extends StatefulWidget {
  // const NotesGrid({
  //   Key key,
  //   @required List<Note> listNote,
  // })  : _listNote = listNote,
  //       super(key: key);

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

List<Note> _listNote = [
  Note(
    id: 'N1',
    title: 'Catatan Materi Flutter',
    note:
        'Flutter merupakan Software Development Kit (SDK) yang bisa membantu developer dalam membuat aplikasi mobile cross platform. Kelas ini akan mempelajari pengembangan aplikasi mobile yang dapat dijalankan baik di IOS maupun di Android',
    updatedAt: DateTime.parse('2021-05-19 20:33:33'),
    createdAt: DateTime.parse('2021-05-19 20:33:33'),
  ),
  Note(
    id: 'N2',
    title: 'Target Pembelajaran Flutter',
    note:
        'Peserta dapat mengembangkan aplikasi mobile (IOS dan Android) menggunakan flutter,\nPeserta memahami konsep pengembangan aplikasi menggunakan flutter,\nPeserta dapat menjalankan aplikasi mobile di IOS dan Android ataupun Emulator,\nPeserta memahami bahasa pemrograman Dart,\nPeserta dapat mendevelop aplikasi mobile menggunakan flutter dan dart dari dasar secara berurutan.',
    updatedAt: DateTime.parse('2021-05-20 20:53:33'),
    createdAt: DateTime.parse('2021-05-20 20:53:33'),
  ),
  Note(
    id: 'N3',
    title: 'Belajar Flutter di ITBOX',
    note: 'Jangan lupa belajar flutter dengan video interactive di ITBOX.',
    updatedAt: DateTime.parse('2021-05-20 21:22:33'),
    createdAt: DateTime.parse('2021-05-20 21:22:33'),
  ),
  Note(
    id: 'N4',
    title: 'Resep nasi goreng',
    note:
        'Nasi putih 1 piring\nBawang putih 2 siung, cincang halus\nKecap manis atau kecap asin sesuai selera\nSaus sambal sesuai selera\nSaus tiram sesuai selera\nGaram secukupnya\nKaldu bubuk rasa ayam atau sapi sesuai selera\nDaun bawang 1 batang, cincang halus\nTelur ayam 1 butir\nSosis ayam 1 buah, iris tipis\nMargarin atau minyak goreng 3 sdm.',
    updatedAt: DateTime.parse('2021-05-20 21:51:33'),
    createdAt: DateTime.parse('2021-05-20 21:51:33'),
  ),
];

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: _listNote.length,
        itemBuilder: (ctx, index) => NoteItem(
          note: _listNote[index].note,
          title: _listNote[index].title,
          isPinned: _listNote[index].isPinned,
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
