import 'package:flutter/material.dart';
import 'package:project_app/database/doa_solat_database.dart';
import 'package:project_app/widget/sidebar.dart';

class DoaSolat extends StatefulWidget {
  const DoaSolat({super.key});

  @override
  State<DoaSolat> createState() => _DoaSolatState();
}

class _DoaSolatState extends State<DoaSolat> {
  List<Map<String, dynamic>> _doaList = [];

  @override
  void initState() {
    super.initState();
    _loadDoa();
  }

  Future<void> _loadDoa() async {
    try {
      final data = await DatabaseDoaSolat.getDoaSolatList();
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
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text('Doa Solat', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: const Text(
              'Doa Panduan Solat',
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
                          doa['title'] ?? 'Tidak ada title',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          doa['arab'] ?? 'Tidak ada arab',
                          style: const TextStyle(
                              fontSize: 25, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          doa['latin'] ?? 'Tidak ada teks Latin',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          'Artinya: ${doa['arti'] ?? 'Tidak ada artinya'}',
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
