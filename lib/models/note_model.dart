import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String note;
  final DateTime updatedAt;
  final DateTime createdAt;
  bool isPinned;

  Note({
    @required this.id,
    @required this.title,
    @required this.note,
    @required this.updatedAt,
    @required this.createdAt,
    this.isPinned = false,
  });

  Note.fromDb(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        note = data['note'],
        isPinned = data['isPinned'] == 1,
        updatedAt = DateTime.parse(data['updated_at']),
        createdAt = DateTime.parse(data['created_at']);

  Note copyWith({
    String id,
    String title,
    String note,
    DateTime updatedAt,
    DateTime createdAt,
    bool isPinned,
  }) {
    return Note(
      id: id == null ? this.id : id,
      title: title == null ? this.title : title,
      note: note == null ? this.note : note,
      updatedAt: updatedAt == null ? this.updatedAt : updatedAt,
      createdAt: createdAt == null ? this.createdAt : createdAt,
      isPinned: isPinned == null ? this.isPinned : isPinned,
    );
  }
}
