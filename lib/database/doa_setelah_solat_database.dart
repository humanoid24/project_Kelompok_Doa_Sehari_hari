import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSetelahFarduSunnah {
  static Database? _database;

  static Future<Database> getDatabaseSetelahSolat() async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'doa_setelah_solat.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE doa_setelah_solatfardu (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          arab TEXT,
          latin TEXT,
          arti TEXT
        )''');

        await db.execute('''CREATE TABLE doa_setelah_solatsunnah (
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
      'assets/doa_setelah_solat_fardu.json',
      'assets/doa_setelah_solat_sunnah.json',
    ];
    for (var file in jsonFiles) {
      await _processJsonFile(db, file);
    }
  }

  static Future<void> _processJsonFile(Database db, String filePath) async {
    try {
      final String jsonString = await rootBundle.loadString(filePath);
      final dynamic jsonData = jsonDecode(jsonString);

      if (filePath.contains('doa_setelah_solat_fardu.json')) {
        final List<dynamic> data = jsonData['doa_usai_shalat_fardhu'];
        for (var item in data) {
          await db.insert(
            'doa_setelah_solatfardu',
            {
              'arab': item['arab'] ?? '',
              'latin': item['latin'] ?? '',
              'arti': item['arti'] ?? '',
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      } else if (filePath.contains('doa_setelah_solat_sunnah.json')) {
        final List<dynamic> data = jsonData;
        for (var item in data) {
          await db.insert(
            'doa_setelah_solatsunnah',
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

  static Future<List<Map<String, dynamic>>> getDoaSetelahSolatFardu() async {
    final db = await getDatabaseSetelahSolat();
    try {
      return await db.query('doa_setelah_solatfardu', orderBy: 'id ASC');
    } catch (e) {
      print('Error fetching data from database: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getDoaSetelahSolatSunnah() async {
    final db = await getDatabaseSetelahSolat();
    try {
      return await db.query('doa_setelah_solatsunnah', orderBy: 'id ASC');
    } catch (e) {
      print('Error fetching data from database: $e');
      return [];
    }
  }
}
