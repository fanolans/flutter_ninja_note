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

  Note copyWith({
    String id,
    String title,
    String note,
    DateTime updatedAt,
    DateTime createdAt,
    bool isPinned,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
