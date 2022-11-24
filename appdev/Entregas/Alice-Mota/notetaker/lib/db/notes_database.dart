import 'dart:async';

import 'package:notetaker/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('note.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final integerType = "INTEGER NOT NULL";
    final textType = "TEXT NOT NULL";

    await db.execute("""
    CREATE TABLE $noteTable(
      ${NoteFields.id} $idType,
      ${NoteFields.title} $textType,
      ${NoteFields.content} $textType,
      ${NoteFields.color} $integerType,
      ${NoteFields.time} $textType   
    )
    """);
  }

  Future insertNote(Note note) async {
    final db = await instance.database;

    final id = await db.insert(noteTable, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(noteTable,
        columns: NoteFields.values,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} DESC';

    final result = await db.query(noteTable, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;

    return db.update(
      noteTable,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int? id) async {
    final db = await instance.database;

    return db.delete(
      noteTable,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
