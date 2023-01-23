import 'dart:convert';

import 'package:note/models/note_model.dart';
import 'package:http/http.dart' as http;

class NoteApi {
  Future<List<Note>> getAllNote() async {
    final uri = Uri.parse(
      'https://ninja-note-1c483-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json',
    );
    final response = await http.get(uri);
    final result = json.decode(response.body) as Map<String, dynamic>;

    List<Note> notes = [];
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
    return notes;
  }

  Future<String> postNote(Note note) async {
    final uri = Uri.parse(
      'https://ninja-note-1c483-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json',
    );
    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'isPinned': note.isPinned,
      'updated_at': note.updatedAt.toIso8601String(),
      'created_at': note.createdAt.toIso8601String(),
    };
    final body = json.encode(map);
    final response = await http.post(uri, body: body);
    print(response.body);
    return json.decode(response.body)['name'];
  }

  Future<void> updateNote(Note note) async {
    final uri = Uri.parse(
      'https://ninja-note-1c483-default-rtdb.asia-southeast1.firebasedatabase.app/notes/${note.id}.json',
    );
    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'updated_at': note.updatedAt.toIso8601String(),
    };
    final body = json.encode(map);
    final response = await http.patch(uri, body: body);
  }

  Future<void> toggleIsPinned(
    String id,
    bool isPinned,
    DateTime updatedAt,
  ) async {
    final uri = Uri.parse(
      'https://ninja-note-1c483-default-rtdb.asia-southeast1.firebasedatabase.app/notes/$id.json',
    );
    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updatedAt.toIso8601String(),
    };
    final body = json.encode(map);
    final response = await http.patch(uri, body: body);
  }
}
