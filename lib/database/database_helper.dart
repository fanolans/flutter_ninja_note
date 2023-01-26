import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> init() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'notes.db'),
      version: 1,
      onCreate: (newDb, version) {
        newDb.execute('''
        CREATE TABLE notes(
          id TEXT,
          title TEXT,
          note TEXT,
          isPinned INTEGER,
          updated_at TEXT,
          created_at TEXT)''');
      },
    );
  }
}
