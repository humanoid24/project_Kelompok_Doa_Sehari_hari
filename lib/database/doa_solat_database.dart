import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseDoaSolat {
  static Database? _database;

  static Future<Database> getDatabaseSolat() async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'doasolat.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE doa_solat (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          arab TEXT,
          latin TEXT,
          arti TEXT
        )''');

        await _loadInitialData(db);
      },
    );
    return _database!;
  }

  static Future<void> _loadInitialData(Database db) async {
    final List<String> jsonFiles = [
      'assets/doa_solat.json',
    ];
    for (var file in jsonFiles) {
      await _processJsonFile(db, file);
    }
  }

  static Future<void> _processJsonFile(Database db, String filePath) async {
    try {
      final String jsonString = await rootBundle.loadString(filePath);
      final dynamic jsonData = jsonDecode(jsonString);

      if (filePath.contains('doa_solat.json')) {
        final List<dynamic> data = jsonData;
        for (var item in data) {
          await db.insert(
            'doa_solat',
            {
              'title': item['title'] ?? '',
              'arab': item['arab'] ?? '',
              'latin': item['latin'] ?? '',
              'arti': item['arti'] ?? '',
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    } catch (e) {
      print('Error processing $filePath: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getDoaSolatList() async {
    final db = await getDatabaseSolat();
    try {
      return await db.query('doa_solat', orderBy: 'id ASC');
    } catch (e) {
      print('Error fetching data from database: $e');
      return [];
    }
  }
}
