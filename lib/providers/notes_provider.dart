import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note/api/note_api.dart';
import 'package:note/database/database_helper.dart';

import '../models/note_model.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [
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

  Future<void> getAndSetNotes() async {
    try {
      _notes = await NoteApi().getAllNote();
      await DatabaseHelper().insertAllNotes(_notes);
      notifyListeners();
    } on SocketException {
      _notes = await DatabaseHelper().getAllNotes();
      notifyListeners();
      return;
    } catch (e) {
      return Future.error(e);
    }
  }

  List<Note> get notes {
    NoteApi().getAllNote();
    List<Note> tempListNote = _notes.where((note) => note.isPinned).toList();
    tempListNote.addAll(_notes.where((note) => !note.isPinned).toList());
    return tempListNote;
  }

  Future<void> toggleIsPinned(String id) async {
    int index = _notes.indexWhere((note) => note.id == id);
    try {
      if (index >= 0) {
        _notes[index].isPinned = !_notes[index].isPinned;
        _notes[index] = _notes[index].copyWith(updatedAt: DateTime.now());
        notifyListeners();

        await NoteApi().toggleIsPinned(
          id,
          _notes[index].isPinned,
          _notes[index].updatedAt,
        );
        await DatabaseHelper().toggleIsPinned(
          id,
          notes[index].isPinned,
          notes[index].updatedAt,
        );
      }
    } catch (e) {
      _notes[index].isPinned = !_notes[index].isPinned;
      notifyListeners();
      Future.error(e);
    }
  }

  Future<void> addNote(Note note) async {
    try {
      String id = await NoteApi().postNote(note);
      note = note.copyWith(id: id);
      await DatabaseHelper().insertNote(note);
      _notes.add(note);
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  Note getNote(String id) {
    return _notes.firstWhere((note) => note.id == id);
  }

  Future<void> updateNote(Note newNote) async {
    try {
      await NoteApi().updateNote(newNote);
      await DatabaseHelper().updateNote(newNote);
      int index = _notes.indexWhere((note) => note.id == newNote.id);
      _notes[index] = newNote;
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> deleteNote(String id) async {
    int index = _notes.indexWhere((note) => note.id == id);
    Note tempNote = _notes[index];
    try {
      _notes.removeAt(index);
      notifyListeners();
      await NoteApi().deleteNote(id);
      await DatabaseHelper().deleteNote(id);
    } catch (e) {
      _notes.insert(index, tempNote);
      notifyListeners();
      return Future.error(e);
    }
  }
}
