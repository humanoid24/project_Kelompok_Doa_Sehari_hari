import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DoaCrudDatabaseSiang {
  static Database ? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'doa_siang_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Membuat tabel tambahan
        await db.execute('''CREATE TABLE doa_siang (
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
  static Future<void> insertDoaSiang(String nama, String arab, String arti) async {
    final db = await getDatabase();
    await db.insert(
      'doa_siang',
      {
        'nama': nama,
        'arab': arab,
        'arti': arti,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateDoaSiang(int id, String nama, String arab, String arti) async {
    final db = await getDatabase();
    await db.update(
      'doa_siang',
      {
        'nama': nama,
        'arab': arab,
        'arti': arti,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteDoaSiang(int id) async {
    final db = await getDatabase();
    await db.delete(
      'doa_siang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getTambahDoaListSiang() async {
    final db = await getDatabase();
    return await db.query('doa_siang', orderBy: 'id ASC');
  }



}