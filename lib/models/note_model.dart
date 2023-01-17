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
}
