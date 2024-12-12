import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  // Mendapatkan instance database
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'doa.db');

    // Untuk debug: Hapus database lama (gunakan ini hanya saat debugging)
    // await deleteDatabase(path);

    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // Membuat tabel doa
        await db.execute('''CREATE TABLE doa (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          arab TEXT,
          latin TEXT,
          arti TEXT
        )''');

        // Membuat tabel tahlil
        await db.execute('''CREATE TABLE tahlil (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          arab TEXT,
          arti TEXT
        )''');

        // Membuat tabel favorites
        await db.execute('''CREATE TABLE favorites (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          doa_id INTEGER,
          FOREIGN KEY (doa_id) REFERENCES doa (id)
        )''');


        // Memuat data awal
        await _loadInitialData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Tambahkan tabel favorites jika versi database lebih lama
        }
      },
    );

    return _database!;
  }

  // Memuat data awal dari file JSON
  static Future<void> _loadInitialData(Database db) async {
    final List<String> jsonFiles = [
      'assets/tahlil.json',
      'assets/doa.json',
    ];

    for (var file in jsonFiles) {
      await _processJsonFile(db, file);
    }
  }

  static Future<void> _processJsonFile(Database db, String filePath) async {
    try {
      final String jsonString = await rootBundle.loadString(filePath);
      final dynamic jsonData = jsonDecode(jsonString);

      if (filePath.contains('tahlil.json')) {
        final List<dynamic> data = jsonData;
        for (var item in data) {
          await db.insert(
            'tahlil',
            {
              'id': item['id'] ?? 0,
              'nama': item['title'] ?? '',
              'arab': item['arabic'] ?? '',
              'arti': item['translation'] ?? '',
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      } else if (filePath.contains('doa.json')) {
        final List<dynamic> data = jsonData;
        for (var item in data) {
          await db.insert(
            'doa',
            {
              'id': item['id'] ?? 0,
              'nama': item['doa'] ?? '',
              'arab': item['ayat'] ?? '',
              'latin': item['latin'] ?? '',
              'arti': item['artinya'] ?? '',
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    } catch (e) {
      print('Error processing $filePath: $e');
    }
  }

  // Mendapatkan daftar doa
  static Future<List<Map<String, dynamic>>> getDoaList() async {
    final db = await getDatabase();
    try {
      return await db.query('doa', orderBy: 'id ASC');
    } catch (e) {
      print('Error fetching data from database: $e');
      return [];
    }
  }

  // Mendapatkan daftar tahlil
  static Future<List<Map<String, dynamic>>> getTahlilList() async {
    final db = await getDatabase();
    try {
      return await db.query('tahlil', orderBy: 'id ASC');
    } catch (e) {
      print('Error fetching data from database: $e');
      return [];
    }
  }

  // Menambahkan doa ke favorit
  static Future<void> addFavorite(int doaId) async {
    final db = await getDatabase();
    try {
      await db.insert(
        'favorites',
        {'doa_id': doaId},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error adding favorite: $e');
    }
  }

  // Menghapus doa dari favorit
  static Future<void> removeFavorite(int doaId) async {
    final db = await getDatabase();
    try {
      await db.delete(
        'favorites',
        where: 'doa_id = ?',
        whereArgs: [doaId],
      );
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  // Mengecek apakah doa ada di favorit
  static Future<bool> isFavorite(int doaId) async {
    final db = await getDatabase();
    final result = await db.query(
      'favorites',
      where: 'doa_id = ?',
      whereArgs: [doaId],
    );
    return result.isNotEmpty;
  }
}
