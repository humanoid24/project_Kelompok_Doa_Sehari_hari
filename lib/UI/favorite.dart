import 'package:flutter/material.dart';
import 'package:project_app/database/database_service.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> _favoriteDoaList = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteDoa();
  }

  Future<void> _loadFavoriteDoa() async {
    try {
      final db = await DatabaseService.getDatabase();
      final result = await db.rawQuery('''
        SELECT doa.* 
        FROM doa 
        INNER JOIN favorites ON doa.id = favorites.doa_id
      ''');

      setState(() {
        _favoriteDoaList = result;
      });
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _favoriteDoaList.isEmpty
          ? const Center(child: Text("Tidak ada doa favorit"))
          : ListView.builder(
        itemCount: _favoriteDoaList.length,
        itemBuilder: (context, index) {
          final doa = _favoriteDoaList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doa['nama'] ?? 'Tidak ada nama',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    doa['arab'] ?? 'Tidak ada teks arab',
                    style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${doa['latin'] ?? 'Tidak ada latin'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Artinya: ${doa['arti'] ?? 'Tidak ada arti'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
