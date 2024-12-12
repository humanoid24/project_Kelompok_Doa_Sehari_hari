import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DoaCrudDatabase {
  static Database ? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'doa_pagi_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Membuat tabel tambahan
        await db.execute('''CREATE TABLE doa_pagi (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          arab TEXT,
          arti TEXT
        )''');
      },
    );

    return _database!;

  }

  // Menambahkan doa ke database tambahan
  static Future<void> insertDoa(String nama, String arab, String arti) async {
    final db = await getDatabase();
    await db.insert(
      'doa_pagi',
      {
        'nama': nama,
        'arab': arab,
        'arti': arti,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateDoa(int id, String nama, String arab, String arti) async {
    final db = await getDatabase();
    await db.update(
      'doa_pagi',
      {
        'nama': nama,
        'arab': arab,
        'arti': arti,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteDoa(int id) async {
    final db = await getDatabase();
    await db.delete(
      'doa_pagi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getTambahDoaList() async {
    final db = await getDatabase();
    return await db.query('doa_pagi', orderBy: 'id ASC');
  }



}