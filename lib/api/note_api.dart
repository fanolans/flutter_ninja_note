import 'dart:convert';
import 'dart:io';

import 'package:note/models/note_model.dart';
import 'package:http/http.dart' as http;

class NoteApi {
  Future<List<Note>> getAllNote() async {
    final uri = Uri.parse(
      'https://ninja-note-7c65b-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json',
    );
    List<Note> notes = [];
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final result = json.decode(response.body) as Map<String, dynamic>;

        result.forEach(
          (key, value) {
            notes.add(
              Note(
                id: key,
                title: value['title'],
                note: value['note'],
                isPinned: value['isPinned'],
                updatedAt: DateTime.parse(value['updated_at']),
                createdAt: DateTime.parse(value['created_at']),
              ),
            );
          },
        );
      } else {
        throw Exception();
      }
    } on SocketException {
      throw const SocketException('Tidak dapat terhubung ke internet');
    } catch (e) {
      throw Exception('Eror, terjadi kesalahan');
    }
    return notes;
  }

  Future<String?> postNote(Note note) async {
    final uri = Uri.parse(
      'https://ninja-note-7c65b-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json',
    );
    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'isPinned': note.isPinned,
      'updated_at': note.updatedAt?.toIso8601String(),
      'created_at': note.createdAt?.toIso8601String(),
    };
    try {
      final body = json.encode(map);
      final response = await http.post(uri, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body)['name'];
      } else {
        throw Exception();
      }
    } on SocketException {
      throw const SocketException('Tidak dapat terhubung ke internet');
    } catch (e) {
      throw Exception('Eror, terjadi kesalahan');
    }
  }

  Future<void> updateNote(Note note) async {
    final uri = Uri.parse(
      'https://ninja-note-7c65b-default-rtdb.asia-southeast1.firebasedatabase.app/notes/${note.id}.json',
    );
    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'updated_at': note.updatedAt!.toIso8601String(),
    };
    try {
      final body = json.encode(map);
      final response = await http.patch(uri, body: body);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } on SocketException {
      throw const SocketException('TIdak dapat terhubung ke internet');
    }
  }

  Future<void> toggleIsPinned(
    String? id,
    bool? isPinned,
    DateTime updatedAt,
  ) async {
    final uri = Uri.parse(
      'https://ninja-note-7c65b-default-rtdb.asia-southeast1.firebasedatabase.app/notes/$id.json',
    );
    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updatedAt.toIso8601String(),
    };
    try {
      final body = json.encode(map);
      final response = await http.patch(uri, body: body);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } on SocketException {
      throw const SocketException('TIdak dapat terhubung ke internet');
    } catch (e) {
      throw Exception('Eror, terjadi kesalahan');
    }
  }

  Future<void> deleteNote(String? id) async {
    final uri = Uri.parse(
      'https://ninja-note-7c65b-default-rtdb.asia-southeast1.firebasedatabase.app/notes/$id.json',
    );
    try {
      final response = await http.delete(uri);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } on SocketException {
      throw const SocketException('TIdak dapat terhubung ke internet');
    } catch (e) {
      throw Exception('Eror, terjadi kesalahan');
    }
  }
}
