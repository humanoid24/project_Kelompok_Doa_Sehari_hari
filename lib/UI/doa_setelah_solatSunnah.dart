import 'package:flutter/material.dart';
import 'package:project_app/database/doa_setelah_solat_database.dart';

class DoaSetelahSolatSunnah extends StatefulWidget {
  const DoaSetelahSolatSunnah({super.key});

  @override
  State<DoaSetelahSolatSunnah> createState() => _DoaSetelahSolatSunnahState();
}

class _DoaSetelahSolatSunnahState extends State<DoaSetelahSolatSunnah> {
  List<Map<String, dynamic>> _doaList = [];

  @override
  void initState() {
    super.initState();
    _loadDoa();
  }

  Future<void> _loadDoa() async {
    try {
      final data = await DatabaseSetelahFarduSunnah.getDoaSetelahSolatSunnah();
      setState(() {
        _doaList = data;
      });
    } catch (e) {
      print('Error loading Doa: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: const Text(
              'Doa Setelah Solat Sunnah',
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
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          doa['title'] ?? 'Tidak ada judul',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          doa['arab'] ?? 'Tidak ada teks Arab',
                          style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          doa['latin'] ?? 'Tidak ada teks Latin',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          'Artinya: ${doa['arti'] ?? 'Tidak ada arti'}',
                          style: const TextStyle(fontSize: 16),
                        ),
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
