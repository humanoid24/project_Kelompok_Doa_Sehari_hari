import 'package:flutter/material.dart';
import 'package:project_app/database/database_service.dart';

class Tahlil extends StatefulWidget {
  const Tahlil({super.key});

  @override
  State<Tahlil> createState() => _TahlilState();
}

class _TahlilState extends State<Tahlil> {
  List<Map<String, dynamic>> _tahlilList = [];

  @override
  void initState() {
    super.initState();
    _loadTahlil();
  }

  Future<void> _loadTahlil() async {
    try {
      final dataTahlil = await DatabaseService.getTahlilList();
      setState(() {
        _tahlilList = dataTahlil;
      });
    } catch (e) {
      print('Error loading Tahlil: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tahlilList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: const Text(
                  'Doa Tahlil',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                        itemCount: _tahlilList.length,
                        itemBuilder: (context, index) {
                final tahlil = _tahlilList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          tahlil['nama'] ?? 'Tidak ada nama',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          tahlil['arab'] ?? 'Tidak ada teks arab',
                          style: const TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          'Artinya: ${tahlil['arti'] ?? 'Tidak ada arti'}',
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
