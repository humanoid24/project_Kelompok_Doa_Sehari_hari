import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DoaCrudDatabaseMalam {
  static Database ? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'doa_malam_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Membuat tabel tambahan
        await db.execute('''CREATE TABLE doa_malam (
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
  static Future<void> insertDoaMalam(String nama, String arab, String arti) async {
    final db = await getDatabase();
    await db.insert(
      'doa_malam',
      {
        'nama': nama,
        'arab': arab,
        'arti': arti,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateDoaMalam(int id, String nama, String arab, String arti) async {
    final db = await getDatabase();
    await db.update(
      'doa_malam',
      {
        'nama': nama,
        'arab': arab,
        'arti': arti,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteDoaMalam(int id) async {
    final db = await getDatabase();
    await db.delete(
      'doa_malam',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getTambahDoaListMalam() async {
    final db = await getDatabase();
    return await db.query('doa_malam', orderBy: 'id ASC');
  }



}