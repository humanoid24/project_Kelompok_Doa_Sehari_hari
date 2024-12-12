import 'package:flutter/material.dart';
import 'package:project_app/database/database_service.dart';

class Doa extends StatefulWidget {
  const Doa({super.key});

  @override
  State<Doa> createState() => _DoaState();
}

class _DoaState extends State<Doa> {
  List<Map<String, dynamic>> _doaList = [];
  Set<int> _favoriteIds = {}; // Melacak ID doa yang ditandai sebagai favorit

  @override
  void initState() {
    super.initState();
    _loadDoa();
  }

  Future<void> _loadDoa() async {
    try {
      final data = await DatabaseService.getDoaList();
      final favoriteIds = await _loadFavorites();

      setState(() {
        _doaList = data;
        _favoriteIds = favoriteIds;
      });
    } catch (e) {
      print('Error loading Doa: $e');
    }
  }

  Future<Set<int>> _loadFavorites() async {
    final db = await DatabaseService.getDatabase();
    final favorites = await db.query('favorites');
    return favorites.map<int>((fav) => fav['doa_id'] as int).toSet();
  }

  Future<void> _toggleFavorite(int doaId) async {
    final isFav = _favoriteIds.contains(doaId);

    setState(() {
      if (isFav) {
        _favoriteIds.remove(doaId);
      } else {
        _favoriteIds.add(doaId);
      }
    });

    // Simpan perubahan ke database
    if (isFav) {
      await DatabaseService.removeFavorite(doaId);
    } else {
      await DatabaseService.addFavorite(doaId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _doaList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: const Text(
                  'Doa Sehari hari',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                        itemCount: _doaList.length,
                        itemBuilder: (context, index) {
                final doa = _doaList[index];
                final doaId = doa['id'];
                final isFavorite = _favoriteIds.contains(doaId);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
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
                        SelectableText(
                          '${doa['latin'] ?? 'Tidak ada latin'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          'Artinya: ${doa['arti'] ?? 'Tidak ada arti'}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => _toggleFavorite(doaId), // Menambahkan/ menghapus favorite
                              icon: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
                        },
                      ),
              ),
            ],
          ),
    );
  }
}
