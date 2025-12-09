import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/event.dart';

class DatabaseService extends ChangeNotifier {
  static Database? _database;

  static Future<void> initialize() async {
    _database = await _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  static Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        description TEXT
      )
    ''');
  }

  Future<int> insertEvent(Event event) async {
    final db = _database;
    if (db == null) return Future.error('Database not initialized');
    
    final id = await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    notifyListeners();
    return id;
  }

  Future<List<Event>> getAllEvents() async {
    final db = _database;
    if (db == null) return [];
    
    final List<Map<String, dynamic>> maps = await db.query('events', orderBy: 'timestamp DESC');
    
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<void> deleteEvent(int id) async {
    final db = _database;
    if (db == null) return;
    
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
  }

  Future<void> clearAllEvents() async {
    final db = _database;
    if (db == null) return;
    
    await db.delete('events');
    notifyListeners();
  }
}