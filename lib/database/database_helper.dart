import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class DatabaseHelper {
  static const tableNotes = 'notes';
  static const tableNotesId = 'id';
  static const tableNotesTitle = 'title';
  static const tableNotesNote = 'note';
  static const tableNotesIsPinned = 'isPinned';
  static const tableNotesUpdatedAt = 'updated_at';
  static const tableNotesCreatedAt = 'created_at';

  static Future<Database> init() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'notes.db'),
      version: 1,
      onCreate: (newDb, version) {
        newDb.execute('''
        CREATE TABLE $tableNotes(
          $tableNotesId TEXT,
          $tableNotesTitle TEXT,
          $tableNotesNote TEXT,
          $tableNotesIsPinned INTEGER,
          $tableNotesUpdatedAt TEXT,
          $tableNotesCreatedAt TEXT)''');
      },
    );
  }

  Future<List<Note>> getAllNotes() async {
    final db = await DatabaseHelper.init();
    final results = await db.query('notes');

    List<Note> listNote = [];
    results.forEach((data) {
      listNote.add(Note.fromDb(data));
    });

    return listNote;
  }

  Future<void> insertAllNotes(List<Note> listNote) async {
    final db = await DatabaseHelper.init();
    Batch batch = db.batch();

    listNote.forEach((note) {
      batch.insert(
        tableNotes,
        note.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    await batch.commit();
  }

  Future<void> updateNote(Note note) async {
    final db = await DatabaseHelper.init();
    await db.update(
      tableNotes,
      note.toDb(),
      where: '$tableNotesId = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> toggleIsPinned(
      String? id, bool isPinned, DateTime updatedAt) async {
    final db = await DatabaseHelper.init();
    await db.update(
      tableNotes,
      {
        tableNotesIsPinned: isPinned ? 1 : 0,
        tableNotesUpdatedAt: updatedAt.toIso8601String(),
      },
      where: '$tableNotesId = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteNote(String? id) async {
    final db = await DatabaseHelper.init();
    await db.delete(
      tableNotes,
      where: '$tableNotesId = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertNote(Note note) async {
    final db = await DatabaseHelper.init();
    await db.insert(
      tableNotes,
      note.toDb(),
    );
  }
}
