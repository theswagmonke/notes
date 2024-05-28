import 'dart:developer';

import 'package:notes/src/feature/notes/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  factory NotesDatabase() {
    return instance;
  }

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("notes.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onOpen: (db) async {
        bool needsUpgrade = await _checkAndUpgradeDB(db);
        if (needsUpgrade) {
          await _upgradeDB(db);
        }
      },
    );
  }

  Future<bool> _checkAndUpgradeDB(Database db) async {
    log('Checking database integrity');

    try {
      List<Map> result = await db.rawQuery('PRAGMA table_info(notes)');
      List<String> columns = result.map((column) => column['name'] as String).toList();

      const expectedColumns = ['id', 'title', 'text', 'category'];

      for (var column in expectedColumns) {
        if (!columns.contains(column)) {
          log('Column $column is missing in the notes table');
          return true;
        }
      }
    } catch (e) {
      log('Error checking database integrity: $e');
      return true;
    }

    log('Database integrity check passed');
    return false;
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const titleType = "TEXT NOT NULL";
    const textType = "TEXT NOT NULL";
    const categoryType = "TEXT NOT NULL";

    log('Creating notes table');

    await db.execute('''
    CREATE TABLE notes 
    (
    id $idType, title $titleType, text $textType, category $categoryType
    )
    ''').then((value) {
      log('Notes table created');
    }).catchError((error) {
      log('Error creating notes table: $error');
    });
  }

  Future _upgradeDB(Database db) async {
    log('Upgrading notes table due to detected conflict');

    await db.execute('DROP TABLE IF EXISTS notes')
        .then((value) {
      log('Existing notes table dropped');
    }).catchError((error) {
      log('Error dropping existing notes table: $error');
    });

    await _createDB(db, 1);
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert("notes", note.toMap());

    return note.copyWith(
      id: id,
    );
  }

  Future<Note> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      "notes",
      columns: ["id", "title", "text", "category"],
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    } else {
      throw Exception("id $id is not found");
    }
  }

  Future<List<Note>> readAll() async {
    final db = await instance.database;
    final result = await db.query("notes");

    return result.map((json) => Note.fromMap(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update("notes", note.toMap(), where: "id = ?", whereArgs: [note.id]);
  }

  Future<int> delete(Note note) async {
    final db = await instance.database;

    return db.delete("notes", where: "id = ?", whereArgs: [note.id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
